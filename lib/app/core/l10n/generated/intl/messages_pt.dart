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

  static String m5(property) => "${property} está vazio";

  static String m6(property) => "${property} precisa ser preenchido";

  static String m7(item) => "Gostaria de deletar ${item}?";

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
        "clipperCut": MessageLookupByLibrary.simpleMessage("Corte na máquina"),
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
        "editServiceType": MessageLookupByLibrary.simpleMessage("Editar Tipo"),
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
        "field": MessageLookupByLibrary.simpleMessage("Campo"),
        "filteringLastMonth":
            MessageLookupByLibrary.simpleMessage("Filtrando pelo mês passado"),
        "filters": MessageLookupByLibrary.simpleMessage("Filtros"),
        "finish": MessageLookupByLibrary.simpleMessage("Finalizar"),
        "fortnight": MessageLookupByLibrary.simpleMessage("Quinzena"),
        "fromTo": m1,
        "googleSignIn":
            MessageLookupByLibrary.simpleMessage("Login com Google"),
        "hi": m2,
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "inUse": m3,
        "incorrectEmailOrPassword":
            MessageLookupByLibrary.simpleMessage("Senha ou email incorretos"),
        "invalidNumber": MessageLookupByLibrary.simpleMessage(
            "Por favor, informe um número válido"),
        "invalidProperty": m4,
        "isEmpty": m5,
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
        "next": MessageLookupByLibrary.simpleMessage("Próximo"),
        "noResults": MessageLookupByLibrary.simpleMessage("Sem resultados"),
        "noServiceTypes": MessageLookupByLibrary.simpleMessage(
            "Parece que você não registrou nenhum tipo de serviço,  clique no botão acima para registrar um novo."),
        "noServices": MessageLookupByLibrary.simpleMessage(
            "Parece que você não registrou nenhum serviço, clique no botão acima para registrar um novo.\n\nLembre-se, aqui você verá os serviços realizados hoje. Para visualizar outras datas, vá para a tela de serviços."),
        "noServicesHome": MessageLookupByLibrary.simpleMessage(
            "Parece que você não registrou nenhum serviço para hoje, clique no botão acima para registrar um novo.\n\nLembre-se, por padrão são exibidos os serviços que você realizou nesse mês. Tente alterar os filtros acima para visualizar datas diferentes."),
        "numberLesserThanZero": MessageLookupByLibrary.simpleMessage(
            "Por favor, informe um número maior ou igual a zero"),
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
        "requiredProperty": m6,
        "save": MessageLookupByLibrary.simpleMessage("Salvar"),
        "saveService": MessageLookupByLibrary.simpleMessage("Salvar Serviço"),
        "saveType": MessageLookupByLibrary.simpleMessage("Salvar Tipo"),
        "search": MessageLookupByLibrary.simpleMessage("Busca"),
        "selectServiceType":
            MessageLookupByLibrary.simpleMessage("Selecione o tipo de serviço"),
        "service": MessageLookupByLibrary.simpleMessage("Serviço"),
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
        "skip": MessageLookupByLibrary.simpleMessage("Pular"),
        "thereIsAnotherAccount": MessageLookupByLibrary.simpleMessage(
            "Já existe uma conta com estas credenciais"),
        "thisService": MessageLookupByLibrary.simpleMessage("esse serviço"),
        "today": MessageLookupByLibrary.simpleMessage("Hoje"),
        "total": MessageLookupByLibrary.simpleMessage("Valor total"),
        "totalReceived": MessageLookupByLibrary.simpleMessage("Total recebido"),
        "tourAppBarDescription": MessageLookupByLibrary.simpleMessage(
            "Aqui você pode cadastrar os tipos de serviços que você realiza e sair da sua conta."),
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
        "tourServiceDetailsDescription": MessageLookupByLibrary.simpleMessage(
            "Clicando no serviço, você pode visualizar todas as informações dele, editar ou deletar."),
        "tourServiceDetailsTitle":
            MessageLookupByLibrary.simpleMessage("Detalhes do Serviço"),
        "tourServiceTypesDescription": MessageLookupByLibrary.simpleMessage(
            "Essas informações te ajudarão a cadastrar facilmente os serviços que realizará. Você pode dar um nome, como \"Cílios - Volume Brasileiro\", preencher o valor padrão, e caso se aplique, o percentual que normalmente é descontado desse serviço."),
        "tourServiceTypesTitle":
            MessageLookupByLibrary.simpleMessage("Tipo de serviço"),
        "tourServicesForm1Description": MessageLookupByLibrary.simpleMessage(
            "Para cadastrar um novo serviço prestado, primeiro selecione um dos tipos de serviço que cadastrou anteriomente e os valores serão preenchidos automaticamente de acordo com os dados daquele tipo de serviço. Caso desejar, você pode alterar os valores para esse serviço em específico."),
        "tourServicesForm1Title":
            MessageLookupByLibrary.simpleMessage("Cadastrar Serviço"),
        "tourServicesForm2Description": MessageLookupByLibrary.simpleMessage(
            "Basta selecionar a data do serviço realizado, a quantidade de serviços realizados, e preencher com uma descrição ou anotação caso desejar."),
        "tourServicesForm2Title":
            MessageLookupByLibrary.simpleMessage("Cadastrar Serviço"),
        "tourServicesInfoDescription": MessageLookupByLibrary.simpleMessage(
            "Aqui você pode filtrar e ordernar os serviços, bem como visualizar o saldo do período selecionado. Você também pode cadastrar os serviços realizados."),
        "tourServicesInfoTitle":
            MessageLookupByLibrary.simpleMessage("Serviços"),
        "tourServicesListDescription": MessageLookupByLibrary.simpleMessage(
            "Esses são todos os serviços que realizou em um determinado período de tempo. Por padrão você verá todos os serviços desse mês."),
        "tourServicesListTitle":
            MessageLookupByLibrary.simpleMessage("Serviços"),
        "unknowError": MessageLookupByLibrary.simpleMessage(
            "Ocorreu um erro desconhecido"),
        "userHasBeenDisabled": MessageLookupByLibrary.simpleMessage(
            "Este usuário foi desabilitado. Entre em contato com o suporte para obter ajuda"),
        "verificationIdIsInvalid": MessageLookupByLibrary.simpleMessage(
            "O Id de verificação inserido é inválido"),
        "week": MessageLookupByLibrary.simpleMessage("Semana"),
        "wouldYouLikeDelete": m7,
        "yesterday": MessageLookupByLibrary.simpleMessage("Ontem")
      };
}
