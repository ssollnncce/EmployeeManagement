<script setup>
import Header from '@/components/Header.vue';
import apiFetch from '@/utils/apiFetch';
import { ref, onMounted, computed } from 'vue';
import { useRouter } from 'vue-router';

const todayDate = ref('');
const tasks = ref({});

const router = useRouter();

const countTasks = computed(() => {
    return tasks.value.length;
});

const fetchTodayTasks = async() => {
    try {
        console.log('Fetching today tasks...');
        const response = await apiFetch('get', '/today-tasks');
        console.log('API Response:', response);

        if (response) {
            console.log('Setting today date to:', response.today);
            todayDate.value = response.today;
            tasks.value = response.tasks;
            console.log('Current todayDate value:', todayDate.value);
            console.log('Current tasks value:', tasks.value);
            console.log(tasks.value);
        } else {
            console.error('Неверный формат ответа от API:', response);
        }
    } catch (error) {
        console.error('Ошибка при получении данных:', error);
    }
}

onMounted(() => {
    console.log('Component mounted, initial todayDate:', todayDate.value);
    fetchTodayTasks();
});

const navigateToCreateTask = () => {
    router.push('/create-task');
};
</script>

<template>
    <div class="display-container">
        <Header />
        <div class="content-container">
            <div class="content-container__header">
                <div class="header-date">
                    <h2>Задач на сегодня: {{ countTasks}}</h2>
                    <h2 style="color: #B0B0B0;">{{ todayDate}}</h2>
                </div>
                <button @click="navigateToCreateTask" class="btn-add-task">+ Создать новую задачу</button>
            </div>
            <div class="content-container__tasks">
                <div class="task-card" v-for="task in tasks" :key="task.id">
                    <div class="task-card__header">
                        <p :class="{'task-card__header-ongoing': task.is_ongoing, 'task-card__header-not-ongoing': !task.is_ongoing}">{{ task.is_ongoing ? 'Уже идет' + ' ' + task.duration : task.start_date + ' - ' + task.end_date }}</p>
                        <h3>{{ task.name }}</h3>
                    </div>
                    <div class="task-card__body">
                        <p>{{ task.description }}</p>
                        <div class="task-card__body-container">
                            <img src="../assets/icons/location.svg" alt="location">
                            <p>{{ task.location }}</p>
                        </div>
                        <div class="task-card__body-container">
                            <img src="../assets/icons/members.svg" alt="members">
                            <p>{{ task.members }}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
    .display-container {
        width: 100%;
        min-height: 100vh;
        display: flex;
    }

    .content-container {
        display: flex;
        flex-direction: column;
        flex: 1;
        margin-left: 20%; /* Ширина навигации */
        padding: 32px;
        box-sizing: border-box;
        padding-top: 32px; /* Такой же отступ как в навигации */
        gap: 1rem;
    }

    .content-container__header {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .header-date {
        display: flex;
        gap: 0.5rem;
    }

    .content-container__tasks{
        display: flex;
        flex-direction: column;
        gap: 1rem;
    }

    .task-card{
        display: flex;
        flex-direction: column;
        gap: 0.5rem;
        background-color: #F6F6F6;
        border-radius: 0.75rem;
        padding: 1.5rem;
    }

    .task-card__body{
        display: flex;
        flex-direction: column;
        gap: 0;
    }

    .task-card__header-ongoing {
        color: #098900;
    }

    .task-card__header-not-ongoing {
        color: black;
    }
    .task-card__body-container {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        margin: 0;
        padding: 0;
    }
    

    @media (max-width: 768px) {
        .content-container {
            margin-left: 0;
            width: 100%;
            margin-top: 80px; /* Отступ только для мобильной версии */
            padding-top: 0; /* Сбрасываем верхний отступ на мобильных */
        }
        .content-container__header {
            display: flex;
            align-items: flex-start;
        }
        .header-date {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
        }
    }
</style>