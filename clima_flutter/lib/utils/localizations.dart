import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class MyLocalizations extends Translations {
  MyLocalizations() {
    initializeDateFormatting();
  }

  static String get locale => Get.deviceLocale.toString();
  static String localeDateFormat(String format, DateTime dateTime) {
    return DateFormat(format, locale).format(dateTime);
  }

  static DateTime parseTime(String timeString) {
    List<String> parts = timeString.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);

    return DateTime(2000, 1, 1, hour, minute);
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          "app_name": "Clima Flutter",
          "login_title": "Login",
          "login_email": "Email",
          "login_pass": "Password",
          "login_welcome": "Welcome to Clima Flutter!",
          "login_button": "Login",
          "email_error": "This email is not valid",
          "pass_error": "This password is not valid",
          "name_error": "This name is not valid",
          "registration_title": "Registration",
          "registration_button": "Register",
          "registration_pass_confirm": "Confirm password",
          "dividar": "  Or continue with  ",
          "forgot_password": "Forgot your password?",
          "forgot_password_text":
              "Don't worry, we'll help you recover it.\nJust enter your email and we'll send you a link so you can reset your password.",
          "recover_password": "Recover password",
          "go_back": "Go back",
          "autherror_unknown": "An unknown error occurred.",
          "autherror_email-already-in-use":
              "The email address is already in use by another account.",
          "autherror_invalid-email": "The email address is badly formatted.",
          "autherror_operation-not-allowed":
              "The email/password accounts are not enabled.",
          "autherror_weak-password": "The password is not strong enough.",
          "autherror_user-disabled":
              "The user corresponding to the given email has been disabled.",
          "autherror_user-not-found":
              "There is no user corresponding to the given email.",
          "autherror_wrong-password":
              "The password is invalid for the given email, or the account corresponding to the email does not have a password set.",
          "autherror_too-many-requests": "Too many requests. Try again later.",
          "autherror_invalid-login-credentials": "Invalid login credentials.",
          "login_success": "You have successfully logged in!",
          "register_success": "You have successfully registered!",
          "login_google_success":
              "You have successfully logged in with Google!",
          "passwords_not_match": "Passwords do not match",
          "password_reset_send_success":
              "Password reset email sent successfully, check your inbox.",
          "email_verification_title": "Email verification",
          "email_verification_text":
              "We have sent you an email to verify your account.\nPlease check your email inbox and click on the link to verify your account.\n\nIf not auto redirected after verification, click on the Continue button.",
          "email_verification_button": "Continue",
          "resend_email_verification": "Resend verification email",
          "verification_email_sent": "Verification email sent",
          "email_verified": "Email verified",
          "good_night": "Good night",
          "good_morning": "Good morning",
          "good_afternoon": "Good afternoon",
          "good_evening": "Good evening",
          "more_info_per_hour_title": "More info per hour",
          "sunrise_sunset_title": "Sunrise and sunset",
          "temperature_per_hour_title": "Temperature per hour",
          "search_location_hint": "Search location",
          "search_location_add_tooltip": "Add location",
          "search_location_remove_tooltip": "Clear location",
          "locality_selected_pin_tooltip": "Select main location",
          "locality_selected_switch_tooltip": "Switch selected location",
          "weather_sunny_description": "Sunny",
          "weather_cloudy_description": "Cloudy",
          "weather_rainy_description": "Rainy",
          "weather_snowy_description": "Snowy",
          "weather_cold_description": "Cold",
          "weather_heatwave_description": "Heatwave",
          "weather_foggy_description": "Foggy",
          "weather_thunderstorm_description": "Thunderstorm",
          "weather_windy_description": "Windy",
          "weather_unknown_description": "Unknown",
          "today_text": "Today, ",
          "no_weather_data": "Not enough data for the selected day",
          "temperature": "Temperature (ºC)",
          "termic_sensation": "Termic sensation (ºC)",
          "rain_probability": "Rain probability (%)",
          "wind_speed": "Wind speed (km/h)",
          "clouds": "Cloudiness",
          "snow_probability": "Snow probability (%)",
          "sunrise_text": "Sunrise",
          "sunset_text": "Sunset",
          "cant_delete_default_location": "Can't delete default location",
          "search_location_delete_tooltip": "Delete location",
          "cant_delete_selected_location": "Can't delete selected location",
          "locality_selected_switch_title": "Switch location",
          "notifications_title": "Notifications",
          "notifications_add_tooltip": "Add a new notification",
          "temperature_name": "Temperature",
          "prob_precipitation_name": "Precipitation probability",
          "wind_speed_name": "Wind speed",
          "cloudiness_name": "Cloudiness",
          "prob_snow_name": "Snow probability",
          "unknown_name": "Undefined",
          "notifications_checkbox_tooltip": "Activate this limitation",
          "notifications_min_title": "Minimum value",
          "notifications_max_title": "Maximum value",
          "notifications_subtitle":
              "Set the value which, when exceeded, a notification will be sent.",
          "notifications_type_title": "Type of meteorological agent",
          "notifications_municipio_title": "Select a municipality",
          "notifications_add_title": "Add notification",
          "credits_title": "Credits",
          "credits_text": "Application developed by:\n\n Sergio de Iscar"
        },
        /*
        'de_DE': {
          "app_name": "Clima Flutter",
        },
        'fr_FR': {
          "app_name": "Clima Flutter",
        },*/
        'es_ES': {
          "app_name": "Clima Flutter",
          "login_title": "Iniciar sesión",
          "login_email": "Correo electrónico",
          "login_pass": "Contraseña",
          "login_welcome": "¡Bienvenido a Clima Flutter!",
          "login_button": "Iniciar sesión",
          "email_error": "Este email no es válido",
          "pass_error": "Esta contraseña no es válida",
          "name_error": "Este nombre no es válido",
          "registration_title": "Registro",
          "registration_button": "Registrarse",
          "registration_pass_confirm": "Confirmar contraseña",
          "dividar": "  O continuar con  ",
          "forgot_password": "¿Olvidaste tu contraseña?",
          "forgot_password_text":
              "No te preocupes, te ayudaremos a recuperarla.\nSolo tienes que introducir tu correo electrónico y te enviaremos un enlace para que puedas restablecer tu contraseña.",
          "recover_password": "Recuperar contraseña",
          "go_back": "Volver",
          "autherror_unknown": "Ha ocurrido un error desconocido.",
          "autherror_email-already-in-use":
              "La dirección de correo electrónico ya está siendo utilizada por otra cuenta.",
          "autherror_invalid-email":
              "La dirección de correo electrónico está mal formateada.",
          "autherror_operation-not-allowed":
              "Las cuentas de correo electrónico / contraseña no están habilitadas.",
          "autherror_weak-password":
              "La contraseña no es lo suficientemente fuerte.",
          "autherror_user-disabled":
              "El usuario correspondiente al correo electrónico indicado ha sido deshabilitado.",
          "autherror_user-not-found":
              "No hay ningún usuario correspondiente al correo electrónico indicado.",
          "autherror_wrong-password":
              "La contraseña no es válida para el correo electrónico indicado, o la cuenta correspondiente al correo electrónico no tiene una contraseña establecida.",
          "autherror_too-many-requests":
              "Demasiadas solicitudes. Inténtalo de nuevo más tarde.",
          "autherror_invalid-login-credentials":
              "Credenciales de inicio de sesión no válidas.",
          "login_success": "¡Has iniciado sesión correctamente!",
          "register_success": "¡Te has registrado correctamente!",
          "login_google_success":
              "¡Has iniciado sesión correctamente con Google!",
          "passwords_not_match": "Las contraseñas no coinciden",
          "password_reset_send_success":
              "Correo electrónico de restablecimiento de contraseña enviado correctamente, revisa tu bandeja de entrada.",
          "email_verification_title": "Verificación de correo electrónico",
          "email_verification_text":
              "Te hemos enviado un correo electrónico para verificar tu cuenta.\nPor favor, revisa tu bandeja de entrada de correo electrónico y haz clic en el enlace para verificar tu cuenta.\n\nSi no se redirige automáticamente después de la verificación, haga clic en el botón Continuar.",
          "email_verification_button": "Continuar",
          "resend_email_verification": "Reenviar correo de verificación",
          "verification_email_sent": "Correo de verificación enviado",
          "email_verified": "Correo electrónico verificado",
          "good_night": "Buenas noches",
          "good_morning": "Buenos días",
          "good_afternoon": "Buenas tardes",
          "good_evening": "Buenas noches",
          "more_info_per_hour_title": "Más información por hora",
          "sunrise_sunset_title": "Amanecer y atardecer",
          "temperature_per_hour_title": "Temperatura por hora",
          "search_location_hint": "Buscar ubicación",
          "search_location_add_tooltip": "Añadir ubicación",
          "search_location_remove_tooltip": "Limpiar ubicación",
          "locality_selected_pin_tooltip": "Seleccionar ubicación principal",
          "locality_selected_switch_tooltip": "Cambiar ubicación seleccionada",
          "weather_sunny_description": "Soleado",
          "weather_cloudy_description": "Nublado",
          "weather_rainy_description": "Lluvioso",
          "weather_snowy_description": "Nevado",
          "weather_cold_description": "Frío",
          "weather_heatwave_description": "Ola de calor",
          "weather_foggy_description": "Brumoso",
          "weather_thunderstorm_description": "Tormenta",
          "weather_windy_description": "Ventoso",
          "weather_unknown_description": "Desconocido",
          "today_text": "Hoy, ",
          "no_weather_data":
              "No hay datos suficientes para el día seleccionado",
          "temperature": "Temperatura (ºC)",
          "termic_sensation": "Sensación térmica (ºC)",
          "rain_probability": "Probabilidad de lluvia (%)",
          "wind_speed": "Velocidad del viento (km/h)",
          "clouds": "Nubosidad",
          "snow_probability": "Probabilidad de nieve (%)",
          "sunrise_text": "Amanecer",
          "sunset_text": "Atardecer",
          "cant_delete_default_location":
              "No se puede borrar la ubicación por defecto",
          "search_location_delete_tooltip": "Borrar ubicación",
          "cant_delete_selected_location":
              "No se puede borrar la ubicación si está seleccionada",
          "locality_selected_switch_title": "Cambiar ubicación",
          "notifications_title": "Notificaciones",
          "notifications_add_tooltip": "Añadir una nueva notificación",
          "temperature_name": "Temperatura",
          "prob_precipitation_name": "Probabilidad de precipitación",
          "wind_speed_name": "Velocidad del viento",
          "cloudiness_name": "Nubosidad",
          "prob_snow_name": "Probabilidad de nieve",
          "unknown_name": "No definido",
          "notifications_checkbox_tooltip": "Activar esta limitación",
          "notifications_min_title": "Valor mínimo",
          "notifications_max_title": "Valor máximo",
          "notifications_subtitle":
              "Establece el valor el cual, al ser superado, se enviará una notificación.",
          "notifications_type_title": "Tipo de agente meteorológico",
          "notifications_municipio_title": "Selecione un municipio",
          "notifications_add_title": "Añadir notificación",
          "credits_title": "Créditos",
          "credits_text": "Aplicación desarrollada por:\n\n Sergio de Iscar"
        },
      };
}
