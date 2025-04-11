<template>
    <div class="display-container">
        <Header />
        <div class="content-container">
            <div class="content-container__header">
                <h2>Уведомления</h2>
                <button class="mark-as-read-btn" @click="markAsRead">Отметить все как прочитанные</button>
            </div>
            <div class="content-container__body">
                <div class="unread-notifications">
                    <h3>Непрочитанные уведомления: </h3>
                    <div class="notification-list" v-for="notification in unreadNotifications" :key="notification.id">
                        <div class="notification-item">
                            <div class="notification-unread-tag"></div>
                            <div class="notification-item_contentt">
                                <h4>{{ notification.message }}</h4>
                                <p>{{ notification.date }}</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="read-notifications">
                    <h3>Прочитанные уведомления: </h3>
                    <div class="notification-list" v-for="notification in readNotifications" :key="notification.id">
                        <div class="notification-item">
                            <div class="notification-item_contentt">
                                <h4>{{ notification.message }}</h4>
                                <p>{{ notification.date }}</p>
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
import { ref, onMounted } from 'vue';
import apiFetch from '@/utils/apiFetch';

const unreadNotifications = ref({});
const readNotifications = ref({});

const markAsRead = async () => {
    try {
        await apiFetch('post', '/notifications');
        fetchNotifications();
    } catch (error) {
        console.error('Ошибка при отметке уведомлений как прочитанных:', error);
    }
};

const fetchNotifications = async () => {
    try{
        const response = await apiFetch('get', '/notifications');
        console.log('Response:', response); // Для отладки
        unreadNotifications.value = response.Unread_notifications;
        readNotifications.value = response.Read_notifications;
    } catch (error) {
        console.error('Ошибка при получении уведомлений:', error);
    }
};

onMounted(() => {
    fetchNotifications();
});

</script> 

<style scoped>
    .notification-item{
        display: flex;
        flex-direction: row;
        width: 100%;
    }
    .content-container__body {
        display: flex;
        flex-direction: column;
        width: 100%;
        gap: 1rem;
    }
    .notifications-unread-tag {
        border-radius: 50%;
        background-color: #000;
        width: 8px;
        height: 8px;
    }

</style>
