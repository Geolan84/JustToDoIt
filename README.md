# to_do

Домашнее задание №3: "Bjarne Stroustrup"

Ссылка на .apk: https://drive.google.com/file/d/1dBoFsna9iNGtHA3Mp7bTucljyGXt-OFT/view?usp=sharing

**Изменения:**

- Выпилил из приложения bloc, переписал всё на elementary.
- Касательно пунктов 3 домашки: сейчас есть только Service Locator на Get.It и state management.
- В общем, эта домашка, видимо, тоже в пролёте, пока что это недоделанная вторая, нежели третья.
- Скриншоты менять не стал, старые всё ещё актуальны.

---

Домашнее задание №2: «Alan Turing»

Ссылка на .apk: https://drive.google.com/file/d/16vsbA8_nYI9AYKSB6-ZNjaGukifr_Czt/view?usp=sharing

**Изменения:**

- В проект был добавлен bloc для управления состоянием (обычно писал на provider или elementary, а тут решил изучить новую либу/архитектуру и потерял очень много времени из-за этого, грустно);
- Поправил баги в UI, декомпозировал виджеты;
- Добавил локализацию, теперь есть две локали: русская и английская;
- Есть получение всех заметок и отправка созданной.
- Из любопытного: добавил fvm и конфиг для запуска для него;
- Токен спрятал в файлик `secrets.json`, закинул его в .gitignore. Чтобы приложение можно было запустить и/или сбилдить, необходимо использовать команду `flutter build apk --dart-define-from-file=secrets.json`. С run то же самое. В самом файлике токен лежит так:

<img src="https://github.com/Geolan84/JustToDoIt/assets/71218029/57198173-1789-4b58-9bfd-e44654ca5361" height="400" />

<img src="https://github.com/Geolan84/JustToDoIt/assets/71218029/995cd5b5-1195-44c2-a7c3-c71b7504524e" height="400" />

---

Домашнее задание №1: «Ada Lovelace»

Ссылка на .apk: https://drive.google.com/file/d/1QHPVSU6VmwAHoR0v9waKcrC6mnl5nxcj/view?usp=sharing

- В наличии два экрана: ToDoListScreen и NewToDoScreen. Не стал отказываться от material 3, поэтому есть небольшие расхождения с дизайном. Отмечу, что это именно свёрстанный интерфейс, пока не стал вводить модель задачи, сохранение и т.п.

- На экране списка задач добавил свайпы по задаче, эти действия логируются.

- Показ выполненных дел не реализован.

- Логирование есть, добавил его для изменения статусов задач на экране ToDoListScreen.

- Дизайнер из меня плохой, поставить фотку Шайа Лабафа (Just TO_DO It) не рискнул, тем не менее иконку приложения сделал, у меня на андроидах и на iOS отобразилась.

Ну и сразу скажу, код слабо декомпозирован, буду рефакторить его уже после внедрения state-менеджера.

Заранее благодарю за уделённое время, буду рад получить обратную связь.

<img src="https://github.com/Geolan84/JustToDoIt/assets/71218029/575d39fd-8f73-4112-9290-9f761d186554" height="400" />

<img src="https://github.com/Geolan84/JustToDoIt/assets/71218029/aaf97658-c527-4080-93f3-60eec459ca3f" height="400" />

<img src="https://github.com/Geolan84/JustToDoIt/assets/71218029/8b578609-8517-49d7-ae58-89e081433c67" height="400" />

<img src="https://github.com/Geolan84/JustToDoIt/assets/71218029/d7aad26d-616a-496b-a51f-e2b6babc639e" height="400" />

<img src="https://github.com/Geolan84/JustToDoIt/assets/71218029/42d8c07c-6050-45fb-a506-88e57355496f" height="400" />
