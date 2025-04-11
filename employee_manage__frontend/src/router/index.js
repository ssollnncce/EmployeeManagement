import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import LoginView from '../views/LoginView.vue'
import TasksView from '../views/TasksView.vue'
import CreateTasksView from '../views/CreateTasksView.vue'
import EmployeesView from '../views/EmployeesView.vue'
import EmployeeDetail from '../views/EmployeeDetail.vue'
import DocumentsView from '../views/DocumentsView.vue'
import NotificationsView from '../views/NotificationsView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView,
      meta: {title: 'Главная'}
    },
    {
      path: '/login',
      name: 'login',
      component: LoginView,
      meta: {title: 'Вход'}
    },
    {
      path: '/tasks',
      name: 'tasks',
      component: TasksView,
      meta: {title: 'Задачи'}
    },
    {
      path: '/create-task',
      name: 'create-task',
      component: CreateTasksView,
      meta: {title: 'Создать задачу'}
    },
    {
      path: '/employees',
      name: 'employees',
      component: EmployeesView,
      meta: {title: 'Сотрудники'}
    },
    {
      path: '/employees/:id',
      name: 'employee-detail',
      component: EmployeeDetail,
      meta: {title: 'Сотрудник'}
    },
    {
      path: '/documents',
      name: 'documents',
      component: DocumentsView,
      meta: {title: 'Документы'}
    },
    {
      path: '/notifications',
      name: 'notifications',
      component: NotificationsView,
      meta: {title: 'Уведомления'}
    }
  ],
})

// Глобальный навигационный хук для обновления заголовка страницы
router.beforeEach((to, from, next) => {
  // Устанавливаем заголовок страницы из метаданных маршрута
  document.title = to.meta.title ? `${to.meta.title} - Employees Manager` : 'Staff Manager';
  next();
});

export default router
