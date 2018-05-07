# Sample blog API

1. Создать пост

   POST '/posts'
   params: { post: { title: "Post title", body: "Post body" }, user: { login: "your_login", ip: "your_ip" } }

2. Поставить оценку посту

   POST 'posts/:post_id/vote'
   params: { post: { rating: "5" } }

3. Получить топ N постов по среднему рейтингу

   GET '/posts/top?count=10'

4. Получить список айпи, с которых постило несколько разных авторов.

   GET '/posts/ip_list'

## Тесты

```bash
bundle exec rspec
```

# SQL

Дана таблица users вида - id, group_id

```sql
CREATE TEMP TABLE users(id bigserial, group_id bigint);
INSERT INTO users(group_id) VALUES (1), (1), (1), (2), (1), (3);

id  | group_id
----+----------
  1 |        1
  2 |        1
  3 |        1
  4 |        2
  5 |        1
  6 |        3
```

В этой таблице, упорядоченой по ID необходимо:

1. Выделить непрерывные группы по group_id с учетом указанного порядка записей (их 4)

```sql
WITH init_groups AS 
(SELECT id, group_id, CASE WHEN lag(group_id) OVER () = group_id THEN 0 ELSE 1 END AS init_group FROM users),
with_init_index AS
(SELECT id, group_id, CASE WHEN init_group = 1 THEN id ELSE 0 END AS init_index FROM init_groups WHERE init_group > 0)

SELECT init_index AS min_id, group_id,
CASE WHEN lead(init_index) OVER () IS NOT NULL THEN lead(init_index) OVER () - init_index ELSE 1 END 
AS count FROM with_init_index;

 min_id | group_id | count 
--------+----------+-------
      1 |        1 |     3
      4 |        2 |     1
      5 |        1 |     1
      6 |        3 |     1
(4 rows)
```

2. Подсчитать количество записей в каждой группе

```sql
SELECT COUNT(id) AS total, group_id FROM users GROUP BY group_id;

 total | group_id 
-------+----------
     4 |        1
     1 |        3
     1 |        2
(3 rows)
```

3. Вычислить минимальный ID записи в группе

```sql
SELECT MIN(id) as min_id, group_id FROM users GROUP BY group_id;

 min_id | group_id 
--------+----------
      1 |        1
      6 |        3
      4 |        2
(3 rows)
```