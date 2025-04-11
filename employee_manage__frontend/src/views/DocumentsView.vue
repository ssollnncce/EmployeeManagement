<template>
    <div class="display-container">
        <Header />
        <div class="content-container">
            <div class="content-container__header">
                <h1>Документы</h1>
            </div>
            <div class="content-container__body">
                <h2>Функция в разработке</h2>
                <p>Пожалуйста, подождите, пока мы разрабатываем эту функцию. Спасибо за понимание!</p>
                <p>В данный момент имееютя некоторые технические трудности, связанные с подписанием документов</p>
            </div>
        </div>
    </div>
</template>

<script setup>

import Header from '@/components/Header.vue';

</script>

<style scoped>
    .content-container__body {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        width: 100%;
    }
</style>
