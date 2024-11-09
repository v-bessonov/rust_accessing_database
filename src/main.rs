#![allow(dead_code, unused_variables, unused_mut, unused_imports)]
// docker build -t mysql-image
// docker run --name mysql-container -d -p 3306:3306 mysql-image

// docker container rm -f mysql-container
// docker container ls
// docker image rm -f mysql-image
// docker image ls

mod types;

use mysql::*;
use mysql::prelude::*;
use crate::types::Employee;

fn main() {
    let mut conn = get_conn();

    create_temp_table(&mut conn);

    insert_employees(&mut conn);

    let employees = select_employees(&mut conn);

    println!("\nEmployees:");

    for e in employees {
        println!("{}", e);
    }
}

fn select_employees(conn: &mut PooledConn) -> Vec::<Employee> {
    conn.query_map(
        "SELECT employee_id, name, salary, region FROM employees_temp",
        |(i, s, n, r)| Employee::new(i, s, n, r),
    ).unwrap()
}

fn insert_employees(conn: &mut PooledConn) {
    let employees = vec![
        Employee::new(1, String::from("Andy"), 25_000.0, String::from("Wales")),
        Employee::new(2, String::from("Jayne"), 35_000.0, String::from("Wales")),
        Employee::new(3, String::from("Emily"), 45_000.0, String::from("Scotland")),
        Employee::new(4, String::from("Tom"), 55_000.0, String::from("London"))
    ];

    conn.exec_batch(
        "INSERT INTO employees_temp (employee_id, name, salary, region) VALUES (:i, :n, :s, :r)",
        employees.iter().map(|e| params! {"i" => e.employee_id, "n" => &e.name, "s" => e.salary, "r" => &e.region}),
    ).unwrap()
}

fn create_temp_table(conn: &mut PooledConn) {
    conn.query_drop(r"
    CREATE TEMPORARY TABLE employees_temp(
        employee_id INT NOT NULL,
        name VARCHAR(50) NOT NULL,
        salary DOUBLE NOT NULL,
        region VARCHAR(50) NOT NULL,
        PRIMARY KEY (employee_id)
    )").unwrap()
}

fn get_conn() -> PooledConn {
    let builder = OptsBuilder::new()
        .ip_or_hostname(Some("localhost"))
        .tcp_port(3306)
        .db_name(Some("MYSCHEMA"))
        .user(Some("root"))
        .pass(Some("password"));

    let pool = Pool::new(builder).unwrap();
    pool.get_conn().unwrap()
}
