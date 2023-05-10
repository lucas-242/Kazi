// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'pt';

  static String m0(property) => "${property} já existe";

  static String m1(start, end) => "De ${start} até ${end}";

  static String m2(person) => "Olá, ${person}!";

  static String m3(property) => "${property} está em uso";

  static String m4(property) => "${property} inválido";

  static String m5(property) => "${property} precisa ser preenchido";

  static String m6(item) => "Gostaria de deletar ${item}?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add": MessageLookupByLibrary.simpleMessage("Adicionar"),
        "all": MessageLookupByLibrary.simpleMessage("Todos"),
        "alreadyExists": m0,
        "appSubtitle":
            MessageLookupByLibrary.simpleMessage("Organize seus serviços"),
        "applyFilters": MessageLookupByLibrary.simpleMessage("Aplicar Filtros"),
        "calculator": MessageLookupByLibrary.simpleMessage("Calculadora"),
        "calendar": MessageLookupByLibrary.simpleMessage("Calendário"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
        "cantDeleteServiceType": MessageLookupByLibrary.simpleMessage(
            "O tipo de serviço não pode ser deletado pois está em uso"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirmar"),
        "confirmAction": MessageLookupByLibrary.simpleMessage("Confirmar Ação"),
        "create": MessageLookupByLibrary.simpleMessage("Criar"),
        "credentialIsInvalid":
            MessageLookupByLibrary.simpleMessage("A credencial é inválida"),
        "darkMode": MessageLookupByLibrary.simpleMessage("Modo escuro"),
        "date": MessageLookupByLibrary.simpleMessage("Data"),
        "defaultValue": MessageLookupByLibrary.simpleMessage("Valor padrão"),
        "delete": MessageLookupByLibrary.simpleMessage("Deletar"),
        "description": MessageLookupByLibrary.simpleMessage("Descrição"),
        "details": MessageLookupByLibrary.simpleMessage("Detalhes"),
        "discount": MessageLookupByLibrary.simpleMessage("Desconto"),
        "discountPercentage":
            MessageLookupByLibrary.simpleMessage("Porcentagem do desconto"),
        "discounts": MessageLookupByLibrary.simpleMessage("Descontos"),
        "edit": MessageLookupByLibrary.simpleMessage("Editar"),
        "editService": MessageLookupByLibrary.simpleMessage("Editar Serviço"),
        "editServiceType":
            MessageLookupByLibrary.simpleMessage("Editar Tipo de Serviço"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "emailIsInvalid": MessageLookupByLibrary.simpleMessage(
            "O email é inválido ou mal formatado"),
        "emailWasNotFound": MessageLookupByLibrary.simpleMessage(
            "O email não foi encontrado, por favor, crie uma conta"),
        "errorToAddService": MessageLookupByLibrary.simpleMessage(
            "Erro ao efetuar a adição do serviço"),
        "errorToAddServiceType": MessageLookupByLibrary.simpleMessage(
            "Erro ao efetuar a adição do tipo de serviço"),
        "errorToCountServices": MessageLookupByLibrary.simpleMessage(
            "Erro ao buscar quantidade de serviços"),
        "errorToDeleteService": MessageLookupByLibrary.simpleMessage(
            "Erro ao efetuar a deleção do serviço"),
        "errorToDeleteServiceType": MessageLookupByLibrary.simpleMessage(
            "Erro ao efetuar a deleção do tipo de serviço"),
        "errorToGetServiceTypes": MessageLookupByLibrary.simpleMessage(
            "Erro ao buscar os tipos de serviços"),
        "errorToGetServices":
            MessageLookupByLibrary.simpleMessage("Erro ao buscar os serviços"),
        "errorToUpdateService": MessageLookupByLibrary.simpleMessage(
            "Erro ao efetuar a edição do serviço"),
        "errorToUpdateServiceType": MessageLookupByLibrary.simpleMessage(
            "Erro ao efetuar a edição do tipo de serviço"),
        "filteringLastMonth":
            MessageLookupByLibrary.simpleMessage("Filtrando pelo mês passado"),
        "filters": MessageLookupByLibrary.simpleMessage("Filtros"),
        "fortnight": MessageLookupByLibrary.simpleMessage("Quinzena"),
        "fromTo": m1,
        "googleSignIn":
            MessageLookupByLibrary.simpleMessage("Login com Google"),
        "hi": m2,
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "inUse": m3,
        "incorrectEmailOrPassword":
            MessageLookupByLibrary.simpleMessage("Senha ou email incorretos"),
        "invalidProperty": m4,
        "lastMonth": MessageLookupByLibrary.simpleMessage("Mês Passado"),
        "lastServices":
            MessageLookupByLibrary.simpleMessage("Últimos serviços"),
        "lightMode": MessageLookupByLibrary.simpleMessage("Modo claro"),
        "linkHasBeenUsed":
            MessageLookupByLibrary.simpleMessage("O link já foi usado"),
        "linkHasExpired":
            MessageLookupByLibrary.simpleMessage("O link expirou"),
        "logout": MessageLookupByLibrary.simpleMessage("Sair"),
        "logoutConfirmation": MessageLookupByLibrary.simpleMessage(
            "Você realmente gostaria de sair?"),
        "methodNotAllowed": MessageLookupByLibrary.simpleMessage(
            "Método não permitido. Tente outra conta ou entre em contato com o suporte para obter ajuda."),
        "month": MessageLookupByLibrary.simpleMessage("Mês"),
        "myBalance": MessageLookupByLibrary.simpleMessage("Meu saldo"),
        "name": MessageLookupByLibrary.simpleMessage("Nome"),
        "newService": MessageLookupByLibrary.simpleMessage("Novo Serviço"),
        "newServiceType":
            MessageLookupByLibrary.simpleMessage("Novo Tipo de Serviço"),
        "newType": MessageLookupByLibrary.simpleMessage("Novo Tipo"),
        "noResults": MessageLookupByLibrary.simpleMessage("Sem resultados"),
        "noServiceTypes": MessageLookupByLibrary.simpleMessage(
            "Parece que você não registrou nenhum tipo de serviço,  clique no botão acima para registrar um novo."),
        "noServices": MessageLookupByLibrary.simpleMessage(
            "Parece que você não registrou nenhum serviço, clique no botão acima para registrar um novo."),
        "onboardingSubtitle": MessageLookupByLibrary.simpleMessage(
            "Esta ferramenta inteligente foi projetada para ajudá-lo a gerenciar melhor seus serviços."),
        "onboardingTitle1":
            MessageLookupByLibrary.simpleMessage("Calcule os\nganhos dos "),
        "onboardingTitle2":
            MessageLookupByLibrary.simpleMessage("seus\nserviços"),
        "orderAlphabetical":
            MessageLookupByLibrary.simpleMessage("Alfabétical"),
        "orderBy": MessageLookupByLibrary.simpleMessage("Ordernar por"),
        "orderDateAsc":
            MessageLookupByLibrary.simpleMessage("Menos atual para mais atual"),
        "orderDateDesc":
            MessageLookupByLibrary.simpleMessage("Mais atual para menos atual"),
        "orderValueAsc":
            MessageLookupByLibrary.simpleMessage("Menor para maior"),
        "orderValueDesc":
            MessageLookupByLibrary.simpleMessage("Maior para menor"),
        "passwordIsWeak": MessageLookupByLibrary.simpleMessage(
            "A senha é muito fraca, por favor, tente outra senha"),
        "period": MessageLookupByLibrary.simpleMessage("Período"),
        "phone": MessageLookupByLibrary.simpleMessage("Telefone"),
        "profile": MessageLookupByLibrary.simpleMessage("Profile"),
        "quantity": MessageLookupByLibrary.simpleMessage("Quantidade"),
        "removeFilters":
            MessageLookupByLibrary.simpleMessage("Remover filtros"),
        "requiredProperty": m5,
        "save": MessageLookupByLibrary.simpleMessage("Salvar"),
        "saveService": MessageLookupByLibrary.simpleMessage("Salvar Serviço"),
        "saveType": MessageLookupByLibrary.simpleMessage("Salvar Tipo"),
        "search": MessageLookupByLibrary.simpleMessage("Busca"),
        "selectServiceType":
            MessageLookupByLibrary.simpleMessage("Selecione o tipo de serviço"),
        "service": MessageLookupByLibrary.simpleMessage("Serviço"),
        "serviceDetails":
            MessageLookupByLibrary.simpleMessage("Detalhes do Serviço"),
        "serviceType": MessageLookupByLibrary.simpleMessage("Tipo de Serviço"),
        "serviceTypes":
            MessageLookupByLibrary.simpleMessage("Tipos de Serviço"),
        "serviceValue":
            MessageLookupByLibrary.simpleMessage("Valor do Serviço"),
        "services": MessageLookupByLibrary.simpleMessage("Serviços"),
        "settings": MessageLookupByLibrary.simpleMessage("Configurações"),
        "share": MessageLookupByLibrary.simpleMessage("Compartilhar"),
        "signIn": MessageLookupByLibrary.simpleMessage("Entrar"),
        "signUp": MessageLookupByLibrary.simpleMessage("Cadastrar"),
        "signUpSuccess": MessageLookupByLibrary.simpleMessage(
            "Cadastro efetuado com sucesso"),
        "thereIsAnotherAccount": MessageLookupByLibrary.simpleMessage(
            "Já existe uma conta com estas credenciais"),
        "thisService": MessageLookupByLibrary.simpleMessage("esse serviço"),
        "today": MessageLookupByLibrary.simpleMessage("Hoje"),
        "total": MessageLookupByLibrary.simpleMessage("Valor total"),
        "totalReceived": MessageLookupByLibrary.simpleMessage("Total recebido"),
        "tourAppBarDescription": MessageLookupByLibrary.simpleMessage(
            "Aqui você encontra a possibilidade de alterar seu número de telefone, e-mail, empresa, alterar sua senha, tipos de serviços, exportar itens, fazer logoff e muito mais."),
        "tourAppBarTitle":
            MessageLookupByLibrary.simpleMessage("Área do Perfil"),
        "tourBottomNavigationServicesDescription":
            MessageLookupByLibrary.simpleMessage(
                "Nesse menu você encontrará todos os serviços que realizou além de poder cadastrar um novo serviço."),
        "tourBottomNavigationServicesTitle":
            MessageLookupByLibrary.simpleMessage("Área de Serviços"),
        "tourHomeBalanceDescription": MessageLookupByLibrary.simpleMessage(
            "Aqui é exibido os seus ganhos diários, o total descontado e o total recebido."),
        "tourHomeBalanceTitle": MessageLookupByLibrary.simpleMessage("Balanço"),
        "tourHomeServicesDescription": MessageLookupByLibrary.simpleMessage(
            "Esses são os serviços que você realizou hoje."),
        "tourHomeServicesTitle":
            MessageLookupByLibrary.simpleMessage("Serviços do dia"),
        "tourProfileDescription": MessageLookupByLibrary.simpleMessage(
            "Aqui você encontrará algumas ações disponíveis, inclusive a de cadastrar um novo tipo de serviço. O tipo de serviço permite que você identifique facilmente um serviço prestado."),
        "tourProfileTitle": MessageLookupByLibrary.simpleMessage("Ações"),
        "tourServiceTypesDescription": MessageLookupByLibrary.simpleMessage(
            "Essas informações te ajudarão a cadastrar facilmente os serviços que realizará. Você pode dar um nome, como \"Cílios - Volume Brasileiro\", preencher o valor padrão, e a porcentagem que será descontada desse serviço caso você trabalhe em um salão que te cobre. Mas não se preocupe, esses valores podem ser alterados sempre que realizar um novo serviço."),
        "tourServiceTypesTitle":
            MessageLookupByLibrary.simpleMessage("Tipo de serviço"),
        "tourServicesListDescription": MessageLookupByLibrary.simpleMessage(
            "Esses são todos os serviços que realizou em um determinado período de tempo. Por padrão você verá todos os serviços do mês, mas também poderá filtrar e ordenar o seus serviços pela data que desejar."),
        "tourServicesListTitle":
            MessageLookupByLibrary.simpleMessage("Serviços"),
        "unknowError": MessageLookupByLibrary.simpleMessage(
            "Ocorreu um erro desconhecido"),
        "userHasBeenDisabled": MessageLookupByLibrary.simpleMessage(
            "Este usuário foi desabilitado. Entre em contato com o suporte para obter ajuda"),
        "verificationIdIsInvalid": MessageLookupByLibrary.simpleMessage(
            "O Id de verificação inserido é inválido"),
        "week": MessageLookupByLibrary.simpleMessage("Semana"),
        "wouldYouLikeDelete": m6,
        "yesterday": MessageLookupByLibrary.simpleMessage("Ontem")
      };
}
