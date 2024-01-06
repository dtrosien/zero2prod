use crate::authentication::UserId;
use crate::session_state::TypedSession;
use crate::utils::see_other;
use actix_web::{web, HttpResponse};
use actix_web_flash_messages::FlashMessage;

pub async fn log_out(
    session: TypedSession,
    // used to check if user is logged in (differs from book, if it does not work check book repo)
    _user_id: web::ReqData<UserId>,
) -> Result<HttpResponse, actix_web::Error> {
    session.log_out();
    FlashMessage::info("You have successfully logged out.").send();
    Ok(see_other("/login"))
}
