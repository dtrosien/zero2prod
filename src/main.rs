use std::net::TcpListener;
use zero2prod::run;
#[tokio::main]
async fn main() -> Result<(), std::io::Error> {
    let listener = TcpListener::bind("127.0.0.1:0").expect("could not bind random address");
    let port = listener.local_addr().unwrap().port();
    let address = &format!("http://127.0.0.1:{}", port);
    println!("server will run at {}", &address);
    run(listener)?.await
}
