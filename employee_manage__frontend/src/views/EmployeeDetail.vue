<template>
    <div class="display-container">
        <Header />
        <div class="content-container">
            <div class="content-container__header">
                <div class="header-nav">
                    <RouterLink to="/employees"><span><img src="../assets/icons/arrow-back.svg" alt="arrow-back"></span></RouterLink>
                    <h2>{{ employee.FullName }}</h2>
                </div>
            </div>
            <div class="employee-detail" v-if="employee">
                <div class="contact-info">
                    <h3>Контактная информация</h3>
                    <div class="info-grid">
                        <div class="info-item">
                            <h4>Телефон</h4>
                            <p>{{ employee.Phone }}</p>
                        </div>
                        <div class="info-item">
                            <h4>Почта</h4>
                            <p>{{ employee.Email }}</p>
                        </div>
                    </div>
                </div>
                <div class="general-info">
                    <h3>Общая информация</h3>
                    <div class="info-grid">
                        <div class="info-item">
                            <h4>Должность</h4>
                            <p>{{ employee.Position }}</p>
                        </div>
                        <div class="info-item">
                            <h4>Руководитель</h4>
                            <p>{{ employee.Manager || 'Не назначен' }}</p>
                        </div>
                        <div class="info-item">
                            <h4>Формат работы</h4>
                            <p>{{ employee['Work mode'] }}</p>
                        </div>
                    </div>
                </div>
            </div>
            <div v-else class="loading">
                Загрузка...
            </div>
        </div>
    </div>
</template>

<script setup>
import Header from '@/components/Header.vue';
import apiFetch from '@/utils/apiFetch';
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';

const route = useRoute();
const employee = ref({});

const fetchEmployeeDetails = async () => {
    try {
        const response = await apiFetch('get', `/employees/${route.params.id}`);
        if (response) {
            employee.value = response;
            console.log('Employee details loaded:', employee.value);
        }
    } catch (error) {
        console.error('Error fetching employee details:', error);
    }
};

onMounted(() => {
    fetchEmployeeDetails();
});
</script>

<style scoped>
.content-container {
    display: flex;
    flex-direction: column;
    flex: 1;
    margin-left: 20%;
    padding: 32px;
    box-sizing: border-box;
    gap: 2rem;
}

.header-nav {
    display: flex;
    align-items: center;
    gap: 1rem;
}

.header-nav h2 {
    margin: 0;
    font-weight: 500;
}

.employee-detail {
    display: flex;
    flex-direction: column;
    gap: 2rem;
}

.contact-info,
.general-info {
    display: flex;
    flex-direction: column;
    gap: 1.5rem;
}

.contact-info h3,
.general-info h3 {
    margin: 0;
    font-size: 1.25rem;
    font-weight: 500;
    color: #333;
}

.info-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 1.5rem;
    background: #F6F6F6;
    border-radius: 0.75rem;
    padding: 1.5rem;
}

.info-item {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
}

.info-item h4 {
    margin: 0;
    font-size: 0.875rem;
    color: #666;
    font-weight: normal;
}

.info-item p {
    margin: 0;
    font-size: 1rem;
    color: #333;
}

.loading {
    text-align: center;
    padding: 2rem;
    color: #666;
}

@media (max-width: 768px) {
    .content-container {
        margin-left: 0;
        width: 100%;
        margin-top: 80px;
        padding: 1rem;
    }

    .info-grid {
        grid-template-columns: 1fr;
    }
}
</style>
