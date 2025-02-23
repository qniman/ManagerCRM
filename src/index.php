<?php
require 'auth_check.php';

$user_login = $_SESSION['login'];
?>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0"/>

    <link rel="stylesheet" href="styles/fonts.css">
    <link rel="stylesheet" href="styles/index.css">
    <title>АРМ "Менеджер"</title>
</head>
<body>
<header>
    <div class="header-logo">АРМ "Менеджер"</div>
    <div id="header-navigation">
        <span id="logoutButton" class="icon-button material-symbols-rounded">logout</span>
    </div>
</header>
<main>
    <div id="side-bar" class="side-bar">
        <div id="side-bar-profile" class="side-bar-profile">
            <img class="side-bar-profile-avatar" src="assets/img/default-avatar.png" alt="Avatar">
            <div class="side-bar-profile-login"><?php echo $user_login?></div>
        </div>
        <div class="separator"></div>
        <div id="createOrderButton" class="accent-button side-bar-button">
            <div class="side-bar-button-text">ДОБАВИТЬ ЗАКАЗ</div>
        </div>
        <div class="separator"></div>
        <div id="ordersTabsButton" class="side-bar-button">
            <div class="side-bar-button-text">ЗАКАЗЫ</div>
        </div>
        <div id="clientsTabButton" class="side-bar-button">
            <div class="side-bar-button-text">КЛИЕНТЫ</div>
        </div>
        <div id="servicesTabButton" class="side-bar-button">
            <div class="side-bar-button-text">УСЛУГИ</div>
        </div>
        <div id="partsTabButton" class="side-bar-button">
            <div class="side-bar-button-text">ЗАПЧАСТИ</div>
        </div>
    </div>
    <div id="content"></div>
    <div id="modals-container"></div>
</main>
<script src="scripts/index.js"></script>
</body>
</html>
