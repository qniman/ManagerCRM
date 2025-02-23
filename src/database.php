<?php

$host = 'db';
$db = 'arm_manager';
$user = 'arm_manager';
$password = 'alqpzmxn';
$port = 3306;
$charset = 'utf8mb4';

$db = new mysqli($host, $user, $password, $db, $port);
if ($db->connect_error) {
    die("Ошибка подключения: " . $db->connect_error);
}
$db->set_charset($charset);