<template>
    <div class="display-container">
        <Header />
        <div class="content-container">
            <div class="content-container__header">
                <h2>Задачи</h2>
                <button class="btn-add-task" @click="navigateToCreateTask">+ Создать новую задачу</button>
            </div>
            <div class="content-container__tasks">
                <div v-for="(group, index) in tasks" :key="index" class="task-group">
                    <h3 class="task-group__date">{{ group.date }}</h3>
                    <div class="task-card" v-for="task in group.tasks" :key="task.id">
                        <div class="task-card__header">
                            <p :class="{'task-card__header-ongoing': task.is_ongoing, 'task-card__header-not-ongoing': !task.is_ongoing}">
                                {{ task.is_ongoing ? 'Уже идет' + ' ' + task.duration : task.start_date + ' - ' + task.end_date }}
                            </p>
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
    </div>
</template>

<script setup>
import Header from '@/components/Header.vue';
import apiFetch from '@/utils/apiFetch';
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';

const tasks = ref({});
const router = useRouter();

const fetchTasks = async () => {
    try {
        const response = await apiFetch('get', '/tasks');
        if (response) {
            tasks.value = response;
            console.log('Tasks loaded:', tasks.value);
        }
    } catch (error) {
        console.error('Error fetching tasks:', error);
    }
};

const navigateToCreateTask = () => {
    router.push('/create-task');
};

onMounted(() => {
    fetchTasks();
});
</script>

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
    margin-left: 20%;
    padding: 32px;
    box-sizing: border-box;
    padding-top: 32px;
    gap: 1rem;
}

.content-container__tasks {
    display: flex;
    flex-direction: column;
    gap: 2rem;
}

.task-group {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.task-group__date {
    font-size: 1.25rem;
    color: #333;
    margin-bottom: 0.5rem;
}

.task-card {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
    background-color: #F6F6F6;
    border-radius: 0.75rem;
    padding: 1.5rem;
}

.task-card__body {
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
        margin-top: 80px;
        padding-top: 0;
    }
    
    .content-container__header {
        display: flex;
        align-items: flex-start;
    }
}
</style>