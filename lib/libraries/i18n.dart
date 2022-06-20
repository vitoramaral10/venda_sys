import 'package:get/get.dart';

class I18N extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'email': 'Email',
          'password': 'Password',
          'forgot_password': 'Forgot Password?',
          'login': 'Login',
          'required_field': 'Required field',
          'email_invalid': 'Email invalid',
          'error': 'Error',
          'user_or_password_invalid': 'User or password invalid',
          'user_not_found': 'User not found',
          'wrong_password': 'Wrong password',
          'home': 'Home',
          'products': 'Products',
          'units_of_measurement': 'Units of measurement',
          'clients': 'Clients',
          'description': 'Description',
          'abbreviation': 'Abbreviation',
          'save': 'Save',
          'cancel': 'Cancel',
        },
        'pt_BR': {
          'email': 'Email',
          'password': 'Senha',
          'forgot_password': 'Esqueceu a senha?',
          'login': 'Entrar',
          'required_field': 'Campo obrigatório',
          'email_invalid': 'Email inválido',
          'error': 'Erro',
          'user_or_password_invalid': 'Usuário ou senha inválidos',
          'user_not_found': 'Usuário não encontrado',
          'wrong_password': 'Senha incorreta',
          'home': 'Home',
          'products': 'Produtos',
          'units_of_measurement': 'Unidades de medida',
          'clients': 'Clientes',
          'description': 'Descrição',
          'abbreviation': 'Abreviação',
          'save': 'Salvar',
          'cancel': 'Cancelar',
        }
      };
}
