<script setup>
    import { useRouter, useRoute } from 'vue-router';
    import apiFetch from '@/utils/apiFetch';
    import { ref, onMounted, onUnmounted, inject, computed } from 'vue';

    const user = ref({});
    const hasNewNotifications = ref(false);
    const menuVisible = ref(false);
    const isMobile = ref(false);

    const router = useRouter();

    const checkMobile = () => {
        isMobile.value = window.innerWidth <= 768;
        if (!isMobile.value) {
            menuVisible.value = true;
        }
    };

    const toggleMenu = () => {
        menuVisible.value = !menuVisible.value;
    };

    const updateUser = async () => {
        try {
            const response = await apiFetch('get', '/user');
            user.value = response.data;

            const responseNotifications = await apiFetch('get', '/notifications');
            // Проверяем, есть ли хотя бы одно уведомление с read_at = null (непрочитанное)
            hasNewNotifications.value = responseNotifications.data.some(notification => notification.read_at === null);
            
            console.log('Уведомления:', responseNotifications);
            console.log('Есть непрочитанные:', hasNewNotifications.value);
        } catch (error) {
            console.error('Ошибка при получении данных', error);
        }
    }

    const logout = async () => {
        try {
            await apiFetch('post', '/logout');
            localStorage.removeItem('user-token');
            router.push('/login');
        } catch (error) {
            console.error('Ошибка при выходе:', error);
        }
    };

    const navigateToNotifications = () => {
        router.push('/notifications');
    };

    onMounted(() => {
        updateUser();
        checkMobile();
        window.addEventListener('resize', checkMobile);
    });

    onUnmounted(() => {
        window.removeEventListener('resize', checkMobile);
    });
</script>

<template>
    <div>
        <!-- Burger button that's always visible on mobile -->
        <button class="burger-fixed" @click="toggleMenu" v-if="isMobile">☰</button>
        
        <div class="header-panel" :class="{ 'header-panel--mobile': isMobile, 'header-panel--visible': menuVisible }">
            <div class="header-panel__content">
                <div class="header-panel__header">
                    <div class="enjoy">
                        <h2>Привет, {{ user.first_name }}</h2>
                    </div>
                    <div class="notifications">
                        <img src="../assets/icons/readNot.svg" alt="notification-icon" v-if="!hasNewNotifications" class="not-icon" @click="navigateToNotifications">
                        <img src="../assets/icons/unreadNot.svg" alt="notification-icon" v-else class="not-icon" @click="navigateToNotifications">
                    </div>
                </div>
                <nav>
                    <RouterLink to="/" class="nav-link" active-class="active-link" exact-active-class="active-link"><span>Главная</span></RouterLink>
                    <RouterLink to="/employees" class="nav-link" :class="{ 'active-link': $route.path.startsWith('/employees') || $route.path.startsWith('/employees/:id') }"><span>Сотрудники</span></RouterLink>
                    <RouterLink to="/tasks" class="nav-link" :class="{ 'active-link': $route.path.startsWith('/tasks') || $route.path.startsWith('/create-task') }"><span>Задачи</span></RouterLink>
                    <RouterLink to="/documents" class="nav-link" active-class="active-link" exact-active-class="active-link"><span>Документы</span></RouterLink>
                </nav>
                <div class="header-panel__logout">
                    <button @click="logout" class="btn-lgt">Выйти из профиля</button>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
    /* Основной контейнер навигации */
    .header-panel {
        position: fixed;
        top: 0;
        left: 0;
        height: 100vh;
        width: 20%;
        padding: 32px 40px;
        box-sizing: border-box;
        display: flex;
        flex-direction: column;
        background-color: white;
        z-index: 1000;
        transition: transform 0.3s ease;
        box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
    }

    /* Состояния мобильной навигации */
    .header-panel--mobile {
        width: 100%;
        transform: translateX(-100%);
    }

    .header-panel--mobile.header-panel--visible {
        transform: translateX(0);
    }

    /* Контейнер для всего содержимого навигации */
    .header-panel__content {
        display: flex;
        flex-direction: column;
        height: 100%;
    }

    /* Кнопка бургер-меню */
    .burger-fixed {
        position: fixed;
        top: 20px;
        left: 20px;
        background: black;
        color: white;
        border: none;
        border-radius: 4px;
        font-size: 24px;
        cursor: pointer;
        padding: 8px 12px;
        z-index: 1001;
        display: none;
    }

    /* Навигационное меню */
    nav {
        margin-top: 16px;
        flex-grow: 1;
    }

    /* Стили ссылок навигации */
    .nav-link {
        padding: 16px 20px;
        border-radius: 0.75rem;
        text-decoration: none;
        color: #838383;
        width: 100%;
        display: block;
        box-sizing: border-box;
        margin-bottom: 8px;
    }

    .active-link {
        background-color: black;
        color: white;
    }

    /* Заголовок с приветствием и уведомлениями */
    .header-panel__header {
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: space-between;
        box-sizing: border-box;
    }

    /* Контейнер приветствия */
    .enjoy {
        flex: 1;
        min-width: 0;
    }

    .enjoy h2 {
        margin: 0;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    /* Контейнер уведомлений */
    .notifications {
        flex-shrink: 0;
        margin-left: 16px;
        display: flex;
        align-items: center;
    }

    .not-icon {
        width: 24px;
        height: 24px;
        display: block;
    }

    /* Кнопка выхода */
    .header-panel__logout {
        margin-top: auto;
    }

    .btn-lgt {
        background-color: transparent;
        color: #838383;
        font-size: 14px;
        padding: 16px 20px;
        border: none;
        cursor: pointer;
        width: 100%;
        text-align: left;
    }

    /* Медиа-запросы для адаптивности */
    @media (max-width: 768px) {
        .burger-fixed {
            display: block;
        }

        .header-panel {
            padding: 16px;
        }

        .header-panel--mobile.header-panel--visible .header-panel__header {
            padding-left: 60px;
        }

        .header-panel__header {
            padding-right: 0;
        }
    }
</style>

