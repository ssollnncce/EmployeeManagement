<script setup>
import {inject, ref, computed} from "vue";
import apiFetch from "@/utils/apiFetch.js";
import {useRouter} from "vue-router";
import ErrorDescription from "@/components/ErrorDescription.vue";

const form = ref({
  data: {
    email: '',
    password: '',
  },
  errors: {},
})
const router = useRouter()
const updateToken = inject('updateToken')
const updateId = inject('updateUserId')

const isFormValid = computed(() => {
  return form.value.data.email == '' && form.value.data.password == '';
})

const sendForm = async () => {
  try {
    form.value.errors = {}

    const result = await apiFetch('post', '/login', form.value.data)

    if (result.error) {
      form.value.errors = result.error.errors
    }

    if (result.code === 401) {
      form.value.errors = {
        email: [result.message]
      }
    }

    if (result.Token) {
      updateToken(result.Token)
      updateId(result.id)
      await router.replace('/')
    }
  } catch (error) {
    console.error('Ошибка при отправке формы:', error)
  }
}
</script>

<template>
    <div class="container">
        <div class="auth-container">


            <div class="auth-container__header">
                <h2>Вход</h2>
                <p>Введите данные для входа в личный кабинет</p>
            </div>

            <div class="auth-container__login-form">
                <form @submit.prevent="sendForm()" method="post">
                    <div class="login-form input-object">
                        <label for="email">E-mail</label>
                        <input type="email" id="email" placeholder="example@gmail.com" v-model="form.data.email" :class="{'input-error' : form.errors.email}">
                        <ErrorDescription :error="form.errors.email" />
                    </div>
                    <div class="password-form input-object">
                        <label for="password">Пароль</label>
                        <input type="password" id="password" v-model="form.data.password" :class="{'input-error' : form.errors.password}">
                        <ErrorDescription :error="form.errors.password" />
                    </div>
                    <div class="logout-form">
                        <button type="submit" :disabled="isFormValid" :class="{'btn-disabled' : isFormValid}">Войти</button>
                    </div>
                </form>
            </div>


        </div>

    </div>
    
</template>

<style scoped> 

    .container {
        display: flex;
        justify-content: center;
        align-items: center;
        width: 100vw;
        height: 100vh;
    }
    .auth-container{
        width: 30%;
        height: 70%;
        display: flex;
        align-items: center;
        flex-direction: column;
        padding: 2rem;
    }
    .auth-container__header{
        width: 100%;
        margin-bottom: 32px;
    }
    .auth-container__login-form{
        width: 100%;
    }
    form{
        width: 100%;
        display: flex;
        flex-direction: column;
        gap: 24px;
    }
    .logout-form{
        width: 100%;
    }
    .logout-form button{
        width: 100%;
    }
    @media (max-width: 600px) {
        .auth-container {
            padding: 1rem;  /* Уменьшаем отступы на мобильных */
        }

        .auth-container__header {
            margin-bottom: 16px;
        }

        form {
            gap: 16px;  /* Уменьшаем отступы между полями */
        }

        .logout-form button {
            padding: 12px;  /* Увеличиваем высоту кнопки для лучшего взаимодействия */
        }
        .auth-container{
            width: 100%;
        }
    }
</style>
