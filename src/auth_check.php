<?php
session_start();

// Проверяем, авторизован ли пользователь
if (!isset($_SESSION['user_id']) || !isset($_SESSION['login']) || !isset($_SESSION['role'])) {
    // Если пользователь не авторизован, перенаправляем на страницу входа
    header('Location: login.php');
    exit();
}

// Опционально: проверка роли пользователя
$allowed_roles = ['admin', 'manager', 'employee']; // Роли, которые имеют доступ
if (!in_array($_SESSION['role'], $allowed_roles)) {
    // Если роль пользователя не входит в список разрешенных, перенаправляем на страницу входа
    header('Location: login.php');
    exit();
}