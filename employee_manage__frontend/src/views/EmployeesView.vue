<template>
    <div class="display-container">
        <Header />
        <div class="content-container">
            <div class="content-container__header">
                <div class="header-content">
                    <h1>Сотрудники</h1>
                </div>
            </div>
            <div class="employees-list">
                <div v-for="employee in employees" :key="employee.id" class="employee-card">
                    <div class="employee-card__info">
                        <div class="employee-card__info-name">
                            <h3>{{ employee.Name }}</h3>
                            <p>{{ employee.Position }}</p>
                        </div>
                        <div class="employee-card__info-manager">
                            <h4>Руководитель</h4>
                            <p>{{ employee.Manager }}</p>
                        </div>
                    </div>
                    <router-link :to="'/employees/' + employee.id" class="employee-card__link">
                        <span><img src="../assets/icons/arrow-to.svg" alt="arrow-to"></span>
                    </router-link>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import apiFetch from '@/utils/apiFetch'
import Header from '@/components/Header.vue'

const employees = ref([])

const fetchEmployees = async () => {
    try {
        const response = await apiFetch('get', '/employees')
        if (response && response.Employees) {
            employees.value = response.Employees
            console.log('Employees loaded:', employees.value)
        }
    } catch (error) {
        console.error('Error fetching employees:', error)
    }
}

onMounted(() => {
    fetchEmployees()
})
</script>

<style scoped>
h3 {
    font-weight: 500;
}

h4 {
    margin: 0;
    font-weight: 400;
}

.content-container {
    background: white;
    border-radius: 1rem;
    padding: 2rem;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    width: 100%;
}

.content-container__header {
    margin-bottom: 2rem;
}

.header-content {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
}

.header-content h1 {
    margin: 0;
}

.employees-list {
    display: grid;
    gap: 1.5rem;
    width: 100%;
}

.employee-card {
    background: #F6F6F6;
    border-radius: 0.75rem;
    padding: 1.5rem;
    transition: transform 0.2s;
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    width: 100%;
    box-sizing: border-box;
}

.employee-card:hover {
    transform: translateY(-2px);
}

.employee-card__link {
    text-decoration: none;
    color: inherit;
}

.employee-card__info {
    display: flex;
    gap: 1rem;
    flex-direction: column;
    width: 100%;
}

.employee-card__info h3 {
    margin: 0 0 0.5rem 0;
    color: #333;
    font-weight: 500;
}

.employee-card__info p {
    margin: 0;
    color: #666;
}

@media (max-width: 768px) {
    .content-container {
        padding: 1rem;
    }

    .employees-list {
        grid-template-columns: 1fr;
    }
}
</style>
