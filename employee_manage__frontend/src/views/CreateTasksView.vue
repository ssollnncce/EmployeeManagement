<script setup>
import Header from '@/components/Header.vue';
import { useRouter } from 'vue-router';
import Multiselect from 'vue-multiselect';
import apiFetch from '@/utils/apiFetch';
import { ref, onMounted } from 'vue';

const router = useRouter();
const employees = ref([]);
const selectedEmployees = ref([]);

// Добавляем ref для полей формы
const taskName = ref('');
const location = ref('');
const startDate = ref('');
const startTime = ref('');
const endDate = ref('');
const endTime = ref('');
const description = ref('');

const fetchEmployees = async () => {
    try {
        const response = await apiFetch('get', '/employees');
        console.log('Raw employees response:', response); // Для отладки
        
        if (response && response.Employees) {
            // Преобразуем данные в массив
            const employeesArray = Array.isArray(response.Employees) 
                ? response.Employees 
                : Object.values(response.Employees);
            
            // Форматируем данные для multiselect
            employees.value = employeesArray.map(emp => ({
                id: emp.id || '',
                name: emp.Name || emp.name || 'Unknown',
                position: emp.Position || emp.position || '',
                manager: emp.Manager || emp.manager || ''
            }));
            
            console.log('Formatted employees:', employees.value); // Для отладки
        } else {
            console.error('Invalid response format:', response);
            employees.value = []; // Устанавливаем пустой массив в случае ошибки
        }
    } catch (error) {
        console.error('Error fetching employees:', error);
        employees.value = []; // Устанавливаем пустой массив в случае ошибки
    }
};

const createTask = async (event) => {
    event.preventDefault(); // Предотвращаем стандартное поведение формы
    
    console.log('Form submission started');
    
    // Проверяем обязательные поля
    if (!taskName.value || !startDate.value || !endDate.value || selectedEmployees.value.length === 0) {
        console.error('Missing required fields:', {
            taskName: taskName.value,
            startDate: startDate.value,
            endDate: endDate.value,
            selectedEmployees: selectedEmployees.value
        });
        return;
    }

    try {
        // Объединяем дату и время
        const startDateTime = `${startDate.value} ${startTime.value || '00:00'}`;
        const endDateTime = `${endDate.value} ${endTime.value || '00:00'}`;

        // Формируем данные для отправки
        const taskData = {
            name: taskName.value,
            location: location.value,
            start_date: startDateTime,
            end_date: endDateTime,
            description: description.value,
            participants: selectedEmployees.value.map(emp => emp.id)
        };

        console.log('Sending task data:', taskData);
        console.log('Current token:', localStorage.getItem('user-token'));

        // Отправляем запрос на создание задачи
        const response = await apiFetch('post', '/create-task', taskData);
        
        console.log('Server response:', response);

        if (response) {
            console.log('Task created successfully, redirecting to tasks page');
            router.push('/tasks');
        } else {
            console.error('No response received from server');
        }
    } catch (error) {
        console.error('Error creating task:', error);
        if (error.response) {
            console.error('Error response:', error.response);
        }
    }
};

onMounted(() => {
    fetchEmployees();
});

const navigateToTasks = () => {
    router.push('/tasks');
};

const getSelectedEmployeeIds = () => {
    return selectedEmployees.value.map(emp => emp.id);
};
</script>

<template>
    <div class="display-container">
        <Header />
        <div class="content-container">
            <div class="content-container__header">
                <div class="header-nav">
                    <RouterLink to="/"><span><img src="../assets/icons/arrow-back.svg" alt="arrow-back"></span></RouterLink>
                    <h2>Создать задачу</h2>
                </div>
                <button class="btn-create-task" @click="createTask">Создать задачу</button>
            </div>
            <form class="create-form" @submit.prevent="createTask">
                <div class="form-size-l">
                    <label for="name" class="create-form_label">Укажите название</label>
                    <input type="text" id="name" v-model="taskName" placeholder="Название" required>
                </div>
                <div class="form-size-l">
                    <label for="location">Укажите местоположение</label>
                    <input id="location" v-model="location" placeholder="Где будет встреча">
                </div>
                <div class="form-size-l">
                    <label class="create-form_label">Укажите дату и время</label>
                    <div class="date-time-container">
                        <div class="date-time-group">
                            <label for="start-date">Начало</label>
                            <div class="input-group">
                                <input type="date" id="start-date" v-model="startDate" required>
                                <input type="time" id="start-time" v-model="startTime">
                            </div>
                        </div>
                        <div class="date-time-group">
                            <label for="end-date">Окончание</label>
                            <div class="input-group">
                                <input type="date" id="end-date" v-model="endDate" required>
                                <input type="time" id="end-time" v-model="endTime">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-size-l">
                    <label class="create-form_label">Добавьте участников</label>
                    <Multiselect
                        v-model="selectedEmployees"
                        :options="employees"
                        :multiple="true"
                        :close-on-select="false"
                        :clear-on-select="false"
                        :preserve-search="true"
                        placeholder="Выберите участников"
                        label="name"
                        track-by="id"
                        :preselect-first="false"
                        :show-labels="false"
                        :select-label="''"
                        :deselect-label="''"
                        :selected-label="''"
                        noResult="Ничего не найдено"
                        required
                    >
                        <template #option="{ option, isSelected }">
                            <div class="employee-option">
                                <span class="employee-name">{{ option.name }}</span>
                                <span class="checkmark" v-if="isSelected">✓</span>
                            </div>
                        </template>
                        <template #tag="{ option, remove }">
                            <span class="multiselect__tag">
                                <span>{{ option.name }}</span>
                                <i class="multiselect__tag-icon" @click="remove(option)"></i>
                            </span>
                        </template>
                    </Multiselect>
                </div>
                <div class="form-size-l">
                    <label for="description" class="create-form_label">Добавьте комментарий</label>
                    <textarea id="description" v-model="description" placeholder="Комментарий" class="description-input"></textarea>
                </div>
            </form>
        </div>
    </div>
</template>

<style src="vue-multiselect/dist/vue-multiselect.css"></style>
<style scoped> 
    .create-form {
        display: flex;
        flex-direction: column;
        gap: 1.5rem;
        width: 60%;
    }
    .form-size-l {
        display: flex;
        flex-direction: column;
        gap: 0.5rem;
    }
    label {
        font-weight: 500;
        color: #000;
    }
    input {
        border-radius: 0.75rem;
        font-size: 14px;
        background-color: #F6F6F6;
        border: none;
        padding: 14px 16px;
    }
    .date-time-container {
        display: flex;
        gap: 2rem;
    }
    .date-time-group {
        display: flex;
        flex-direction: column;
        gap: 0.5rem;
        flex: 1;
    }
    .input-group {
        display: flex;
        gap: 0.5rem;
    }
    .input-group input {
        flex: 1;
    }
    .content-container {
        display: flex;
        flex-direction: column;
        gap: 1rem;
        flex: 1;
        margin-left: 20%;
        padding: 32px;
        box-sizing: border-box;
    }
    .content-container__header {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .header-nav {
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }
    .employee-option {
        display: flex;
        align-items: center;
        justify-content: space-between;
        width: 100%;
    }
    .employee-name {
        font-weight: 500;
    }
    .employee-position {
        font-size: 0.8em;
        color: #666;
    }
    .checkmark {
        color: #F7941D;
        font-weight: bold;
    }

    /* Стили для Multiselect */
    :deep(.multiselect) {
        min-height: auto;
        border-radius: 0.75rem;
        background-color: #F6F6F6;
        position: relative;
    }
    :deep(.multiselect__tags) {
        min-height: auto;
        padding: 14px 16px;
        border: none;
        background-color: #F6F6F6;
        border-radius: 0.75rem;
    }
    :deep(.multiselect__input) {
        background-color: #F6F6F6;
        padding: 0;
        margin: 0;
        font-size: 14px;
        border-radius: 0.75rem;
    }
    :deep(.multiselect__single) {
        margin: 0;
        padding: 0;
        background-color: transparent;
        border-radius: 0.75rem;
    }
    :deep(.multiselect__select) {
        border-radius: 0 0.75rem 0.75rem 0;
    }
    :deep(.multiselect__content-wrapper) {
        border: none;
        border-radius: 0.75rem;
        margin-top: 0.5rem;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        position: absolute;
        width: 100%;
        background: white;
        z-index: 1000;
        max-height: 300px;
        overflow-y: auto;
    }
    :deep(.multiselect__option) {
        padding: 14px 16px;
        display: block;
    }
    :deep(.multiselect__option--highlight) {
        background: #F7941D;
        color: white;
    }
    :deep(.multiselect__option--highlight::after) {
        background: #F7941D;
    }
    :deep(.multiselect__tag) {
        background: #F7941D;
        color: white;
        border-radius: 0.5rem;
        padding: 4px 8px;
        margin: 2px;
    }
    :deep(.multiselect__tag-icon) {
        background: #F7941D;
    }
    :deep(.multiselect__tag-icon:hover) {
        background: #d67c16;
    }
    :deep(.multiselect__tag-icon::after) {
        color: white;
        content: "×";
    }
    :deep(.multiselect__placeholder) {
        color: #838383;
        margin: 0;
        padding: 0;
    }
    :deep(.multiselect--active) {
        z-index: 1001;
    }
    textarea {
        border-radius: 0.75rem;
        font-size: 14px;
        background-color: #F6F6F6;
        border: none;
        padding: 14px 16px;
        resize: none;
        min-height: 100px;
        font-family: inherit;
    }
    textarea:focus {
        outline: none;
    }
</style>