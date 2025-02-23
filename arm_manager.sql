use arm_manager;

-- Таблица профилей пользователей (менеджеров)
CREATE TABLE IF NOT EXISTS crm_users
(
    id           INTEGER PRIMARY KEY AUTO_INCREMENT,
    login        VARCHAR(20)  NOT NULL UNIQUE,
    password     VARCHAR(255) NOT NULL, -- Хэшированный пароль
    firstname    VARCHAR(50),
    lastname     VARCHAR(50),
    patronymic   VARCHAR(50),
    phone_number VARCHAR(15),
    role         ENUM ('admin', 'manager', 'employee'),
    last_login   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Таблица клиентов
CREATE TABLE IF NOT EXISTS crm_clients
(
    id           INTEGER PRIMARY KEY AUTO_INCREMENT,
    firstname    VARCHAR(50) NOT NULL,
    lastname     VARCHAR(50) NOT NULL,
    patronymic   VARCHAR(50),
    phone_number VARCHAR(15) NOT NULL,
    email        VARCHAR(100),
    address      VARCHAR(255),
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_phone_number (phone_number),
    INDEX idx_email (email)
);

-- Таблица заказов
CREATE TABLE IF NOT EXISTS crm_orders
(
    id                  INTEGER PRIMARY KEY AUTO_INCREMENT,
    problem_description TEXT,
    client_id           INTEGER NOT NULL,
    cost                DECIMAL(10, 2),
    status              ENUM ('pending', 'in_progress', 'completed', 'cancelled') DEFAULT 'pending',
    created_at          TIMESTAMP                                                 DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP                                                 DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (client_id) REFERENCES crm_clients (id) ON DELETE CASCADE,
    INDEX idx_status (status)
);

-- Таблица услуг
CREATE TABLE IF NOT EXISTS crm_services
(
    id          INTEGER PRIMARY KEY AUTO_INCREMENT,
    name        VARCHAR(100)   NOT NULL,
    description TEXT,
    cost        DECIMAL(10, 2) NOT NULL,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Таблица связи заказов и услуг
CREATE TABLE IF NOT EXISTS crm_order_services
(
    id         INTEGER PRIMARY KEY AUTO_INCREMENT,
    order_id   INTEGER NOT NULL,
    service_id INTEGER NOT NULL,
    quantity   INTEGER DEFAULT 1,
    FOREIGN KEY (order_id) REFERENCES crm_orders (id) ON DELETE CASCADE,
    FOREIGN KEY (service_id) REFERENCES crm_services (id) ON DELETE CASCADE,
    UNIQUE KEY unique_order_service (order_id, service_id)
);

-- Таблица запчастей
CREATE TABLE IF NOT EXISTS crm_repair_parts
(
    id          INTEGER PRIMARY KEY AUTO_INCREMENT,
    name        VARCHAR(100)   NOT NULL,
    cost        DECIMAL(10, 2) NOT NULL,
    description TEXT,
    stock       INTEGER   DEFAULT 0,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Таблица связи заказов и запчастей
CREATE TABLE IF NOT EXISTS crm_order_repair_parts
(
    id             INTEGER PRIMARY KEY AUTO_INCREMENT,
    order_id       INTEGER NOT NULL,
    repair_part_id INTEGER NOT NULL,
    quantity       INTEGER DEFAULT 1,
    FOREIGN KEY (order_id) REFERENCES crm_orders (id) ON DELETE CASCADE,
    FOREIGN KEY (repair_part_id) REFERENCES crm_repair_parts (id) ON DELETE CASCADE,
    UNIQUE KEY unique_order_repair_part (order_id, repair_part_id)
);

-- Таблица истории изменений заказов
CREATE TABLE IF NOT EXISTS crm_order_history
(
    id          INTEGER PRIMARY KEY AUTO_INCREMENT,
    order_id    INTEGER NOT NULL,
    changed_by  INTEGER NOT NULL, -- ID пользователя или сотрудника, внесшего изменения
    change_type ENUM ('status_change', 'cost_change', 'description_change', 'other'),
    old_value   TEXT,
    new_value   TEXT,
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES crm_orders (id) ON DELETE CASCADE,
    FOREIGN KEY (changed_by) REFERENCES crm_users (id) ON DELETE CASCADE
);

-- Таблица уведомлений
CREATE TABLE IF NOT EXISTS crm_notifications
(
    id         INTEGER PRIMARY KEY AUTO_INCREMENT,
    user_id    INTEGER NOT NULL, -- ID пользователя, которому отправлено уведомление
    message    TEXT    NOT NULL,
    is_read    BOOLEAN   DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES crm_users (id) ON DELETE CASCADE
);

INSERT INTO crm_users (login, password, role)
VALUES ('admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 'admin');