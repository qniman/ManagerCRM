<?php
session_start();
require 'database.php'; // Подключение к базе данных
$message = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Проверка на пустые поля
    if (empty($_POST['login']) || empty($_POST['password'])) {
        $message = "Пожалуйста, заполните все поля.";
    } else {
        $login = trim($_POST['login']);
        $password = trim($_POST['password']);

        // Используем подготовленные выражения для защиты от SQL-инъекций
        $stmt = $db->prepare("SELECT * FROM crm_users WHERE login = ?");
        $stmt->bind_param("s", $login);
        $stmt->execute();
        $result = $stmt->get_result();
        $user = $result->fetch_assoc();

        if ($user && hash('sha256', $password) === $user['password']) {
            // Успешная авторизация
            $_SESSION['user_id'] = $user['id'];
            $_SESSION['login'] = $user['login'];
            $_SESSION['role'] = $user['role'];
            header('Location: index.php');
            exit();
        } else {
            $message = "Неверный логин или пароль.";
        }
    }
}
?>

<!doctype html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="styles/fonts.css">
    <link rel="stylesheet" href="styles/login.css">
    <title>Авторизация | АРМ "Менеджер"</title>
</head>
<body>
<form class="form" action="login.php" method="post">
    <div class="form-header">АРМ "Менеджер"<span>Авторизация</span></div>
    <div class="form-message">
        <?php echo $message; ?>
    </div>
    <div class="form-text">
        <label for="login">Логин</label>
        <input required type="text" name="login" id="login" placeholder="Введите логин...">
    </div>
    <div class="form-text">
        <label for="password">Пароль</label>
        <input required type="password" name="password" id="password" placeholder="Введите пароль...">
    </div>
    <input type="submit" class="form-button" value="Авторизация">
</form>
</body>
</html>