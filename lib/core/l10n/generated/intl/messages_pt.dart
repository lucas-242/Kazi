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

  static String m1(url) => "Não foi possível carregar a url ${url}";

  static String m2(start, end) => "Fitrando de ${start} até ${end}";

  static String m3(start, end) => "De ${start} até ${end}";

  static String m4(person) => "Olá, ${person}!";

  static String m5(property) => "${property} está em uso";

  static String m6(property) => "${property} inválido";

  static String m7(property) => "${property} está vazio";

  static String m8(property) => "${property} precisa ser preenchido";

  static String m9(item) => "Gostaria de deletar ${item}?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add": MessageLookupByLibrary.simpleMessage("Adicionar"),
        "all": MessageLookupByLibrary.simpleMessage("Todos"),
        "alreadyExists": m0,
        "alreadyHasAccont":
            MessageLookupByLibrary.simpleMessage("Já possui uma conta? "),
        "appSubtitle":
            MessageLookupByLibrary.simpleMessage("Organize seus serviços"),
        "applyFilters": MessageLookupByLibrary.simpleMessage("Aplicar Filtros"),
        "back": MessageLookupByLibrary.simpleMessage("Voltar"),
        "calculator": MessageLookupByLibrary.simpleMessage("Calculadora"),
        "calendar": MessageLookupByLibrary.simpleMessage("Calendário"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
        "changePassword": MessageLookupByLibrary.simpleMessage("Alterar Senha"),
        "clipperCut": MessageLookupByLibrary.simpleMessage("Corte na máquina"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirmar"),
        "confirmAction": MessageLookupByLibrary.simpleMessage("Confirmar Ação"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("Confirme a Senha"),
        "contactEmail":
            MessageLookupByLibrary.simpleMessage("guimaraeslucas242@gmail.com"),
        "create": MessageLookupByLibrary.simpleMessage("Criar"),
        "createAccount": MessageLookupByLibrary.simpleMessage("Crie uma Conta"),
        "currentPassword": MessageLookupByLibrary.simpleMessage("Senha Atual"),
        "darkMode": MessageLookupByLibrary.simpleMessage("Modo escuro"),
        "date": MessageLookupByLibrary.simpleMessage("Data"),
        "defaultValue": MessageLookupByLibrary.simpleMessage("Valor padrão"),
        "delete": MessageLookupByLibrary.simpleMessage("Deletar"),
        "description": MessageLookupByLibrary.simpleMessage("Descrição"),
        "details": MessageLookupByLibrary.simpleMessage("Detalhes"),
        "didntReceiveAnything":
            MessageLookupByLibrary.simpleMessage("Não recebeu nada? "),
        "discount": MessageLookupByLibrary.simpleMessage("Desconto"),
        "discountPercentage":
            MessageLookupByLibrary.simpleMessage("Porcentagem do desconto"),
        "discounts": MessageLookupByLibrary.simpleMessage("Descontos"),
        "doesntHaveAccount":
            MessageLookupByLibrary.simpleMessage("Não possui uma conta? "),
        "edit": MessageLookupByLibrary.simpleMessage("Editar"),
        "editService": MessageLookupByLibrary.simpleMessage("Editar Serviço"),
        "editServiceType": MessageLookupByLibrary.simpleMessage("Editar Tipo"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "errorLaunchUrl": m1,
        "errorNotFound":
            MessageLookupByLibrary.simpleMessage("Endereço não encontrado."),
        "errorTimeout": MessageLookupByLibrary.simpleMessage(
            "O Servidor demorou a responder. Tente novamente mais tarde ou entre em contato conosco."),
        "errorToAddService": MessageLookupByLibrary.simpleMessage(
            "Erro ao efetuar a adição do serviço."),
        "errorToAddServiceType": MessageLookupByLibrary.simpleMessage(
            "Erro ao efetuar a adição do tipo de serviço."),
        "errorToCountServices": MessageLookupByLibrary.simpleMessage(
            "Erro ao buscar quantidade de serviços."),
        "errorToDeleteService": MessageLookupByLibrary.simpleMessage(
            "Erro ao efetuar a deleção do serviço."),
        "errorToDeleteServiceType": MessageLookupByLibrary.simpleMessage(
            "Erro ao efetuar a deleção do tipo de serviço."),
        "errorToGetServiceTypes": MessageLookupByLibrary.simpleMessage(
            "Erro ao buscar os tipos de serviços."),
        "errorToGetServices":
            MessageLookupByLibrary.simpleMessage("Erro ao buscar os serviços."),
        "errorToResetPassword":
            MessageLookupByLibrary.simpleMessage("Erro ao redefinir senha."),
        "errorToSendEmail":
            MessageLookupByLibrary.simpleMessage("Erro ao enviar email."),
        "errorToSignIn": MessageLookupByLibrary.simpleMessage(
            "Erro ao fazer login. Tente novamente mais tarde ou contate o suporte."),
        "errorToSignUp": MessageLookupByLibrary.simpleMessage(
            "Erro ao efetuar cadastro. Tente novamente mais tarde ou contate o suporte."),
        "errorToUpdateService": MessageLookupByLibrary.simpleMessage(
            "Erro ao efetuar a edição do serviço."),
        "errorToUpdateServiceType": MessageLookupByLibrary.simpleMessage(
            "Erro ao efetuar a edição do tipo de serviço."),
        "errorUnknowError": MessageLookupByLibrary.simpleMessage(
            "Ocorreu um erro desconhecido."),
        "exit": MessageLookupByLibrary.simpleMessage("Sair"),
        "field": MessageLookupByLibrary.simpleMessage("Campo"),
        "filteringFromTo": m2,
        "filteringLastMonth":
            MessageLookupByLibrary.simpleMessage("Filtrando pelo mês passado"),
        "filteringToday":
            MessageLookupByLibrary.simpleMessage("Filtrando por hoje"),
        "filters": MessageLookupByLibrary.simpleMessage("Filtros"),
        "finish": MessageLookupByLibrary.simpleMessage("Finalizar"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("Recuperar Senha"),
        "forgotPasswordConfirmation1":
            MessageLookupByLibrary.simpleMessage("Nós enviamos um email para "),
        "forgotPasswordConfirmation2": MessageLookupByLibrary.simpleMessage(
            " para recuperar sua senha. Depois de receber o e-mail, siga o link fornecido para fazer login."),
        "forgotPasswordInfo": MessageLookupByLibrary.simpleMessage(
            "Informe seu email para receber o link para redefinir sua senha."),
        "forgotYourPassword":
            MessageLookupByLibrary.simpleMessage("Esqueceu sua senha?"),
        "fortnight": MessageLookupByLibrary.simpleMessage("Quinzena"),
        "fromTo": m3,
        "googleSignIn":
            MessageLookupByLibrary.simpleMessage("Login com Google"),
        "hi": m4,
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "inUse": m5,
        "invalidIntNumber": MessageLookupByLibrary.simpleMessage(
            "Por favor, informe um número inteiro válido"),
        "invalidNumber": MessageLookupByLibrary.simpleMessage(
            "Por favor, informe um número válido"),
        "invalidProperty": m6,
        "isEmpty": m7,
        "lastMonth": MessageLookupByLibrary.simpleMessage("Mês Passado"),
        "lastServices":
            MessageLookupByLibrary.simpleMessage("Últimos serviços"),
        "leaveApp": MessageLookupByLibrary.simpleMessage(
            "Você quer mesmo sair do app?"),
        "lightMode": MessageLookupByLibrary.simpleMessage("Modo claro"),
        "logout": MessageLookupByLibrary.simpleMessage("Sair"),
        "logoutConfirmation": MessageLookupByLibrary.simpleMessage(
            "Você realmente gostaria de sair?"),
        "month": MessageLookupByLibrary.simpleMessage("Mês"),
        "myBalance": MessageLookupByLibrary.simpleMessage("Meu saldo"),
        "name": MessageLookupByLibrary.simpleMessage("Nome"),
        "newPassword": MessageLookupByLibrary.simpleMessage("Nova Senha"),
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
        "numberBiggerThan100": MessageLookupByLibrary.simpleMessage(
            "Por favor, informe um número menor ou igual a 100"),
        "numberLesserThanZero": MessageLookupByLibrary.simpleMessage(
            "Por favor, informe um número maior ou igual a zero"),
        "onboardingSubtitle": MessageLookupByLibrary.simpleMessage(
            "Esta ferramenta inteligente foi projetada para ajudá-lo a gerenciar melhor seus serviços."),
        "onboardingTitle1":
            MessageLookupByLibrary.simpleMessage("Calcule os\nganhos dos "),
        "onboardingTitle2":
            MessageLookupByLibrary.simpleMessage("seus\nserviços"),
        "or": MessageLookupByLibrary.simpleMessage("ou"),
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
        "password": MessageLookupByLibrary.simpleMessage("Senha"),
        "period": MessageLookupByLibrary.simpleMessage("Período"),
        "phone": MessageLookupByLibrary.simpleMessage("Telefone"),
        "pricayPoliceLinks": MessageLookupByLibrary.simpleMessage(
            "Este Serviço pode conter links para outros sites. Se você clicar em um link de terceiros, será direcionado para esse site. Observe que esses sites externos não são operados por mim. Portanto, aconselho fortemente que você revise a Política de Privacidade desses sites. Não tenho controle e não assumo nenhuma responsabilidade pelo conteúdo, políticas de privacidade ou práticas de sites ou serviços de terceiros."),
        "pricayPoliceLinksTitle":
            MessageLookupByLibrary.simpleMessage("Links para outros sites"),
        "privacyPolice":
            MessageLookupByLibrary.simpleMessage("Política de Privacidade"),
        "privacyPoliceChanges": MessageLookupByLibrary.simpleMessage(
            "Posso atualizar nossa Política de Privacidade de tempos em tempos. Assim, você é aconselhado a revisar esta página periodicamente para quaisquer alterações. Vou notificá-lo sobre quaisquer alterações, publicando a nova Política de Privacidade nesta página.\nEsta política é efetiva a partir de 2023-05-26"),
        "privacyPoliceChangesTitle": MessageLookupByLibrary.simpleMessage(
            "Mudanças nesta Política de Privacidade"),
        "privacyPoliceChildren": MessageLookupByLibrary.simpleMessage(
            "Esses Serviços não se dirigem a menores de 13 anos. Não coleto intencionalmente informações de identificação pessoal de crianças menores de 13 anos. No caso de eu descobrir que uma criança menor de 13 anos me forneceu informações pessoais, eu as excluo imediatamente de nossos servidores. Se você é pai ou responsável e está ciente de que seu filho nos forneceu informações pessoais, entre em contato comigo para que eu possa tomar as medidas necessárias."),
        "privacyPoliceChildrenTitle":
            MessageLookupByLibrary.simpleMessage("Privacidade das crianças"),
        "privacyPoliceContact": MessageLookupByLibrary.simpleMessage(
            "Se tiver alguma dúvida ou sugestão sobre a minha Política de Privacidade, não hesite em contactar-me em "),
        "privacyPoliceContactTitle":
            MessageLookupByLibrary.simpleMessage("Contate-nos"),
        "privacyPoliceCookies": MessageLookupByLibrary.simpleMessage(
            "Cookies são arquivos com uma pequena quantidade de dados que são comumente usados como identificadores únicos anônimos. Estes são enviados para o seu navegador a partir dos sites que você visita e são armazenados na memória interna do seu dispositivo.\nEste Serviço não usa esses “cookies” explicitamente. No entanto, o aplicativo pode usar código e bibliotecas de terceiros que usam “cookies” para coletar informações e melhorar seus serviços. Você tem a opção de aceitar ou recusar esses cookies e saber quando um cookie está sendo enviado ao seu dispositivo. Se você optar por recusar nossos cookies, talvez não consiga usar algumas partes deste Serviço."),
        "privacyPoliceCookiesTitle":
            MessageLookupByLibrary.simpleMessage("Cookies"),
        "privacyPoliceEnd": MessageLookupByLibrary.simpleMessage(
            "Esta página de política de privacidade foi criada em privacypolicytemplate.net e modificada/gerada pelo App Privacy Policy Generator."),
        "privacyPoliceInformation": MessageLookupByLibrary.simpleMessage(
            "Para uma melhor experiência, ao usar nosso Serviço, posso exigir que você nos forneça certas informações de identificação pessoal, incluindo, entre outras, Nome, Endereço de e-mail. As informações que solicito serão mantidas em seu dispositivo e não serão coletadas por mim de forma alguma.\nO aplicativo usa serviços de terceiros que podem coletar informações usadas para identificá-lo.\nLink para a política de privacidade de provedores de serviços terceirizados usados pelo app:\n"),
        "privacyPoliceInformation1":
            MessageLookupByLibrary.simpleMessage("Serviços do Google Play"),
        "privacyPoliceInformation2":
            MessageLookupByLibrary.simpleMessage("AdMob"),
        "privacyPoliceInformation3":
            MessageLookupByLibrary.simpleMessage("Google Analytics"),
        "privacyPoliceInformation4":
            MessageLookupByLibrary.simpleMessage("Firebase Crashlytics"),
        "privacyPoliceInformationTitle":
            MessageLookupByLibrary.simpleMessage("Coleta e uso de informações"),
        "privacyPoliceLogData": MessageLookupByLibrary.simpleMessage(
            "Quero informar que sempre que você usa meu Serviço, em caso de erro no aplicativo, eu coleto dados e informações (através de produtos de terceiros) em seu telefone chamado Log Data. Esses dados de registro podem incluir informações como endereço de protocolo de Internet (\"IP\") do dispositivo, nome do dispositivo, versão do sistema operacional, configuração do aplicativo ao utilizar meu serviço, hora e data de uso do serviço e outras estatísticas."),
        "privacyPoliceLogDataTitle":
            MessageLookupByLibrary.simpleMessage("Dados de registro"),
        "privacyPoliceSecurity": MessageLookupByLibrary.simpleMessage(
            "Eu valorizo sua confiança em nos fornecer suas informações pessoais, portanto, estamos nos esforçando para usar meios comercialmente aceitáveis de protegê-las. Mas lembre-se que nenhum método de transmissão pela internet, ou método de armazenamento eletrônico é 100% seguro e confiável, e não posso garantir sua segurança absoluta."),
        "privacyPoliceSecurityTitle":
            MessageLookupByLibrary.simpleMessage("Segurança"),
        "privacyPoliceServices": MessageLookupByLibrary.simpleMessage(
            "Posso contratar empresas e indivíduos terceirizados pelos seguintes motivos:\n\nPara facilitar nosso Serviço;\nPara fornecer o Serviço em nosso nome;\nPara realizar serviços relacionados ao Serviço; ou\nPara nos ajudar a analisar como nosso Serviço é usado.\n\nDesejo informar aos usuários deste Serviço que esses terceiros têm acesso às suas Informações Pessoais. O motivo é realizar as tarefas atribuídas a eles em nosso nome. No entanto, eles são obrigados a não divulgar ou usar as informações para qualquer outra finalidade."),
        "privacyPoliceServicesTitle":
            MessageLookupByLibrary.simpleMessage("Provedores de Serviço"),
        "privacyPoliceStart": MessageLookupByLibrary.simpleMessage(
            "Lucas Guimarães criou o aplicativo Kazi como um aplicativo suportado por anúncios. Este SERVIÇO é fornecido pela Lucas Guimarães sem custos e destina-se a ser utilizado tal como está.\nEsta página é usada para informar os visitantes sobre minhas políticas de coleta, uso e divulgação de informações pessoais, caso alguém decida usar meu serviço.\nSe você optar por usar meu serviço, concorda com a coleta e o uso de informações relacionadas a esta política. As Informações Pessoais que eu coleto são usadas para fornecer e melhorar o Serviço. Não usarei ou compartilharei suas informações com ninguém, exceto conforme descrito nesta Política de Privacidade.\nOs termos usados nesta Política de Privacidade têm os mesmos significados que em nossos Termos e Condições, que podem ser acessados no Kazi, a menos que definido de outra forma nesta Política de Privacidade."),
        "profile": MessageLookupByLibrary.simpleMessage("Profile"),
        "quantity": MessageLookupByLibrary.simpleMessage("Quantidade"),
        "removeFilters":
            MessageLookupByLibrary.simpleMessage("Remover filtros"),
        "requiredProperty": m8,
        "resendEmail": MessageLookupByLibrary.simpleMessage("Reenviar Email"),
        "resetedPassword": MessageLookupByLibrary.simpleMessage(
            "Senha redefinida com sucesso"),
        "save": MessageLookupByLibrary.simpleMessage("Salvar"),
        "saveService": MessageLookupByLibrary.simpleMessage("Salvar Serviço"),
        "saveType": MessageLookupByLibrary.simpleMessage("Salvar Tipo"),
        "search": MessageLookupByLibrary.simpleMessage("Busca"),
        "selectServiceType":
            MessageLookupByLibrary.simpleMessage("Selecione o tipo de serviço"),
        "sendEmail": MessageLookupByLibrary.simpleMessage("Enviar Email"),
        "service": MessageLookupByLibrary.simpleMessage("Serviço"),
        "serviceAdded": MessageLookupByLibrary.simpleMessage(
            "Serviço adicionado com sucesso"),
        "serviceDeleted": MessageLookupByLibrary.simpleMessage(
            "Serviço deletado com sucesso"),
        "serviceType": MessageLookupByLibrary.simpleMessage("Tipo de Serviço"),
        "serviceTypes":
            MessageLookupByLibrary.simpleMessage("Tipos de Serviço"),
        "serviceUpdated":
            MessageLookupByLibrary.simpleMessage("Serviço editado com sucesso"),
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
        "updatePassword":
            MessageLookupByLibrary.simpleMessage("Altualizar Senha"),
        "userTermsAlert1": MessageLookupByLibrary.simpleMessage(
            "Ao continuar, você concorda com os "),
        "userTermsAlert2":
            MessageLookupByLibrary.simpleMessage("Termos de Serviço "),
        "userTermsAlert3":
            MessageLookupByLibrary.simpleMessage("e confirma que leu a nossa "),
        "userTermsAlert4":
            MessageLookupByLibrary.simpleMessage("Política de Privacidade"),
        "validatorConfirmPassword":
            MessageLookupByLibrary.simpleMessage("As senhas não conferem"),
        "validatorEmail":
            MessageLookupByLibrary.simpleMessage("Email inválido"),
        "validatorPassword": MessageLookupByLibrary.simpleMessage(
            "Sua senha deve ter no mínimo 8 caracteres e no máximo 16"),
        "week": MessageLookupByLibrary.simpleMessage("Semana"),
        "wouldYouLikeDelete": m9,
        "yesterday": MessageLookupByLibrary.simpleMessage("Ontem"),
        "yourEarnings": MessageLookupByLibrary.simpleMessage("Seus Ganhos Hoje")
      };
}
