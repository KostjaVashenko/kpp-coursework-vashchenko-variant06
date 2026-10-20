DROP DATABASE IF EXISTS road_defects;
CREATE DATABASE road_defects CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE road_defects;

-- Таблиця локацій (ділянок дорожньої мережі)
CREATE TABLE location (
                          id BIGINT PRIMARY KEY AUTO_INCREMENT,
                          code VARCHAR(40) NOT NULL,
                          name VARCHAR(160) NOT NULL,
                          city VARCHAR(120) NOT NULL
);

-- Таблиця дефектів дорожньої інфраструктури
CREATE TABLE defect (
                        id BIGINT PRIMARY KEY AUTO_INCREMENT,
                        location_id BIGINT NOT NULL,
                        defect_type VARCHAR(80) NOT NULL,
                        traffic_intensity DOUBLE NOT NULL,
                        limit_intensity DOUBLE NOT NULL,
                        severity_score DOUBLE NOT NULL,
                        hazard_score DOUBLE NOT NULL,
                        state VARCHAR(30) NOT NULL,
                        f1 DOUBLE NOT NULL,
                        f2 DOUBLE NOT NULL,
                        f3 DOUBLE NOT NULL,
                        risk_index DOUBLE NOT NULL,
                        FOREIGN KEY (location_id) REFERENCES location(id)
);

-- Таблиця ремонтних бригад
CREATE TABLE crew (
                      id BIGINT PRIMARY KEY AUTO_INCREMENT,
                      code VARCHAR(40) NOT NULL,
                      name VARCHAR(160) NOT NULL,
                      specialization VARCHAR(120) NOT NULL
);

-- Таблиця нарядів на виконання робіт
CREATE TABLE work_order (
                            id BIGINT PRIMARY KEY AUTO_INCREMENT,
                            defect_id BIGINT NOT NULL,
                            crew_id BIGINT NOT NULL,
                            description VARCHAR(500) NOT NULL,
                            planned_date VARCHAR(10),
                            FOREIGN KEY (defect_id) REFERENCES defect(id),
                            FOREIGN KEY (crew_id) REFERENCES crew(id)
);

-- Початкові демонстраційні дані
INSERT INTO location (code, name, city) VALUES
                                            ('LOC-01', 'вул. Соборності, ділянка 1', 'Полтава'),
                                            ('LOC-02', 'просп. Миру, ділянка 2', 'Полтава');

INSERT INTO defect (location_id, defect_type, traffic_intensity, limit_intensity, severity_score, hazard_score, state, f1, f2, f3, risk_index) VALUES
                                                                                                                                                   (1, 'Вибоїна', 38.0, 25.0, 60.0, 70.0, 'REPORTED', 52.0, 60.0, 70.0, 59.30),
                                                                                                                                                   (2, 'Тріщина покриття', 55.0, 50.0, 30.0, 40.0, 'VERIFIED', 10.0, 30.0, 40.0, 24.50);

INSERT INTO crew (code, name, specialization) VALUES
                                                  ('CRW-01', 'Бригада №1 (асфальтування)', 'Ямковий ремонт покриття'),
                                                  ('CRW-02', 'Бригада №2 (герметизація)', 'Ремонт тріщин і деформаційних швів');

INSERT INTO work_order (defect_id, crew_id, description, planned_date) VALUES
                                                                           (1, 1, 'Фрезерування та укладання гарячого асфальтобетону на ділянці №1', '2026-10-25'),
                                                                           (2, 2, 'Очищення та герметизація поздовжньої тріщини бітумною мастикою', '2026-10-27');