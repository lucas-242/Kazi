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

  static String m1(amount) => "${amount} já recebidos";

  static String m2(version, year) => "Kazi ${version} · ${year}";

  static String m3(date) => "Arquivado em ${date}";

  static String m4(name) => "${name} arquivado.";

  static String m5(count) =>
      "${Intl.plural(count, one: 'Fecha em 1 dia', other: 'Fecha em ${count} dias')}";

  static String m6(day) => "Dia ${day}";

  static String m7(count) => "a cada ${count} dias";

  static String m8(range) => "Ciclo atual: ${range}";

  static String m9(start, end) => "${start} a ${end}";

  static String m10(count, amount) =>
      "${Intl.plural(count, one: 'Ele nomeia 1 serviço já registrado. Excluir agora deixaria esse lançamento sem identificação.', other: 'Ele nomeia ${count} serviços já registrados. Excluir agora deixaria esses lançamentos sem identificação — e eles somam ${amount} no seu histórico.')}";

  static String m11(count) =>
      "${Intl.plural(count, one: 'Não é possível excluir: 1 serviço usa este registro.', other: 'Não é possível excluir: ${count} serviços usam este registro.')}";

  static String m12(name) => "${name} não pode ser excluído";

  static String m13(name) =>
      "\"${name}\" já existe no seu catálogo, arquivado. Deseja restaurá-lo?";

  static String m14(done, total) => "${done}/${total}";

  static String m15(count, name) =>
      "${Intl.plural(count, one: 'Já existe ${name} com 1 serviço. Se for a mesma pessoa, use a que já existe para não dividir o histórico.', other: 'Já existe ${name} com ${count} serviços. Se for a mesma pessoa, use a que já existe para não dividir o histórico.')}";

  static String m16(name, service, date) =>
      "Já existe ${name}, atendido pela última vez em ${date} para ${service}. Se for a mesma pessoa, use a que já existe para não dividir o histórico.";

  static String m17(name) =>
      "Já existe ${name}. Se for a mesma pessoa, use a que já existe para não dividir o histórico.";

  static String m18(name) =>
      "Você já tem um cliente com este documento: ${name}.";

  static String m19(name) =>
      "${name} já está cadastrado com este documento, arquivado. Restaure esse cliente em vez de criar outro.";

  static String m20(month) => "cliente desde ${month}";

  static String m21(count) =>
      "${Intl.plural(count, one: '1 serviço do catálogo está sem comissão', other: '${count} serviços do catálogo estão sem comissão')}";

  static String m22(percent, amount) => "${percent} de ${amount}";

  static String m23(percent) => "Comissão ${percent}";

  static String m24(term) => "Criar “${term}” no catálogo";

  static String m25(count) =>
      "Vamos aplicar isso a ${count} serviços já cadastrados.";

  static String m26(days) =>
      "${Intl.plural(days, zero: 'fecha hoje', one: 'fecha amanhã', other: 'fecha em ${days} dias')}";

  static String m27(count, amount) =>
      "${Intl.plural(count, one: 'de ${amount} gerados em 1 serviço', other: 'de ${amount} gerados em ${count} serviços')}";

  static String m28(count) =>
      "${Intl.plural(count, one: 'O serviço já realizado continua no histórico. Só os dados de contato são apagados. Esta ação não tem volta.', other: 'Os ${count} serviços já realizados continuam no histórico. Só os dados de contato são apagados. Esta ação não tem volta.')}";

  static String m29(name) => "Excluir ${name} para sempre?";

  static String m30(url) => "Não foi possível carregar a url ${url}";

  static String m31(start, end) => "Fitrando de ${start} até ${end}";

  static String m32(latest, current) =>
      "Versão ${latest} · você está na ${current}";

  static String m33(count) => "${count} serviços no catálogo";

  static String m34(count) => "${count} clientes";

  static String m35(count) => "${count} serviços / mês";

  static String m36(start, end) => "De ${start} até ${end}";

  static String m37(amount) => "de ${amount} gerados";

  static String m38(amount) => "de ${amount} cobrados dos clientes";

  static String m39(person) => "Olá, ${person}!";

  static String m40(property) => "${property} está em uso";

  static String m41(property) => "${property} inválido";

  static String m42(property) => "${property} está vazio";

  static String m43(count) =>
      "${Intl.plural(count, one: '1 item', other: '${count} itens')}";

  static String m44(date) => "Último em ${date}";

  static String m45(privacy) => "Ao continuar, você aceita a ${privacy}.";

  static String m46(count) =>
      "${Intl.plural(count, one: 'Marcar o 1 pendente como recebido', other: 'Marcar os ${count} pendentes como recebidos')}";

  static String m47(amount) =>
      "São ${amount} no total. Isso não muda os valores nem as datas — só registra que o pagamento entrou.";

  static String m48(count) =>
      "${Intl.plural(count, one: 'Marcar 1 serviço como recebido?', other: 'Marcar ${count} serviços como recebidos?')}";

  static String m49(count) =>
      "${Intl.plural(count, one: 'O 1 serviço que já estava recebido não é tocado.', other: 'Os ${count} serviços que já estavam recebidos não são tocados.')}";

  static String m50(term) => "Nada encontrado para “${term}”";

  static String m51(amount) => "de ${amount}";

  static String m52(price) => "${price}/mês";

  static String m53(price) => "7 dias grátis, depois ${price}/mês.";

  static String m54(amount) => "${amount} pendentes";

  static String m55(period) => "${period} · seu ganho";

  static String m56(count) =>
      "${Intl.plural(count, one: 'Mudar o preço aqui vale para os próximos registros. O serviço já lançado continua com o valor da época.', other: 'Mudar o preço aqui vale para os próximos registros. Os ${count} serviços já lançados continuam com o valor da época.')}";

  static String m57(date) => "Recebido em ${date}";

  static String m58(property) => "${property} precisa ser preenchido";

  static String m59(name) => "${name} restaurado.";

  static String m60(count, amount) =>
      "${Intl.plural(count, one: '1 serviço', other: '${count} serviços')} · ${amount} para você";

  static String m61(count) =>
      "${Intl.plural(count, zero: 'Nenhum serviço', one: 'Ver 1 serviço', other: 'Ver ${count} serviços')}";

  static String m62(month) => "Ver resumo de ${month}";

  static String m63(count) =>
      "${Intl.plural(count, one: 'Ver o 1 serviço', other: 'Ver os ${count} serviços')}";

  static String m64(count) =>
      "${Intl.plural(count, one: '1 serviço', other: '${count} serviços')}";

  static String m65(count) => "Continuar com ${count}";

  static String m66(day) => "dia ${day}";

  static String m67(total, percent) => "de ${total} · comissão de ${percent}";

  static String m68(count) => "Ver todos (${count})";

  static String m69(count) =>
      "${Intl.plural(count, one: 'Hoje · 1 serviço', other: 'Hoje · ${count} serviços')}";

  static String m70(name) => "Usar ${name} que já existe";

  static String m71(count) =>
      "${Intl.plural(count, one: 'usado em 1 serviço', other: 'usado em ${count} serviços')}";

  static String m72(count) =>
      "${Intl.plural(count, one: '1 uso', other: '${count} usos')}";

  static String m73(count) => "Ver arquivados · ${count}";

  static String m74(version) => "Versão ${version}";

  static String m75(item) => "Gostaria de deletar ${item}?";

  static String m76(amount) => "Seu ganho: ${amount}";

  static String m77(amount) => "${amount} são seus";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("Sobre"),
    "actions": MessageLookupByLibrary.simpleMessage("Ações"),
    "add": MessageLookupByLibrary.simpleMessage("Adicionar"),
    "addClient": MessageLookupByLibrary.simpleMessage("Adicionar cliente"),
    "address": MessageLookupByLibrary.simpleMessage("Endereço"),
    "all": MessageLookupByLibrary.simpleMessage("Todos"),
    "allClients": MessageLookupByLibrary.simpleMessage("Todos os clientes"),
    "allReceipts": MessageLookupByLibrary.simpleMessage("Todas"),
    "alreadyExists": m0,
    "alreadyHasAccont": MessageLookupByLibrary.simpleMessage(
      "Já possui uma conta? ",
    ),
    "alreadyReceived": m1,
    "amount": MessageLookupByLibrary.simpleMessage("Valor"),
    "appSubtitle": MessageLookupByLibrary.simpleMessage(
      "Organize seus serviços",
    ),
    "appVersionFooter": m2,
    "applyFilters": MessageLookupByLibrary.simpleMessage("Aplicar Filtros"),
    "archive": MessageLookupByLibrary.simpleMessage("Arquivar"),
    "archived": MessageLookupByLibrary.simpleMessage("Arquivado"),
    "archivedCatalogItems": MessageLookupByLibrary.simpleMessage(
      "Catálogo arquivado",
    ),
    "archivedCatalogNote": MessageLookupByLibrary.simpleMessage(
      "Item arquivado não aparece ao registrar um serviço, mas continua nomeando os serviços em que já foi usado.",
    ),
    "archivedClients": MessageLookupByLibrary.simpleMessage(
      "Clientes arquivados",
    ),
    "archivedClientsNote": MessageLookupByLibrary.simpleMessage(
      "Cliente arquivado some das buscas e do formulário, mas continua no histórico dos serviços que já foram registrados.",
    ),
    "archivedOn": m3,
    "archivedSectionLabel": MessageLookupByLibrary.simpleMessage("Arquivados"),
    "archivedSnackbar": m4,
    "attention": MessageLookupByLibrary.simpleMessage("Atenção"),
    "back": MessageLookupByLibrary.simpleMessage("Voltar"),
    "billingCycle": MessageLookupByLibrary.simpleMessage("Ciclo de pagamento"),
    "billingCycleClosesInDays": m5,
    "billingCycleDay": m6,
    "billingCycleDescription": MessageLookupByLibrary.simpleMessage(
      "O Kazi soma seus ganhos dentro desse período. É ele que define o número grande do Início.",
    ),
    "billingCycleFortnightly": MessageLookupByLibrary.simpleMessage(
      "Quinzenal",
    ),
    "billingCycleFrequency": m7,
    "billingCycleLastDay": MessageLookupByLibrary.simpleMessage("Último dia"),
    "billingCycleMonthly": MessageLookupByLibrary.simpleMessage("Mensal"),
    "billingCycleOther": MessageLookupByLibrary.simpleMessage("Outro"),
    "billingCyclePayday": MessageLookupByLibrary.simpleMessage(
      "Dia em que recebo",
    ),
    "billingCyclePaydayWeekday": MessageLookupByLibrary.simpleMessage(
      "Dia da semana em que recebo",
    ),
    "billingCyclePayoutDayGroup": MessageLookupByLibrary.simpleMessage(
      "Você recebe no dia",
    ),
    "billingCyclePreview": m8,
    "billingCycleRange": m9,
    "billingCycleSave": MessageLookupByLibrary.simpleMessage("Salvar ciclo"),
    "billingCycleWeekly": MessageLookupByLibrary.simpleMessage("Semanal"),
    "birthDate": MessageLookupByLibrary.simpleMessage("Aniversário"),
    "byCatalogItem": MessageLookupByLibrary.simpleMessage("Por serviço"),
    "calculator": MessageLookupByLibrary.simpleMessage("Calculadora"),
    "calendar": MessageLookupByLibrary.simpleMessage("Calendário"),
    "call": MessageLookupByLibrary.simpleMessage("Ligar"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
    "cantDeleteBody": m10,
    "cantDeleteLinkedServices": m11,
    "cantDeleteReassurance": MessageLookupByLibrary.simpleMessage(
      "Arquivado já basta: o item não aparece mais quando você registra um serviço novo.",
    ),
    "cantDeleteTitle": m12,
    "catalogAll": MessageLookupByLibrary.simpleMessage("Todos"),
    "catalogItem": MessageLookupByLibrary.simpleMessage("Serviço"),
    "catalogItemArchivedRestorePrompt": m13,
    "catalogItemDuplicateName": MessageLookupByLibrary.simpleMessage(
      "Já existe um item com este nome. Use outro nome ou edite o que existe.",
    ),
    "catalogItemFormHint": MessageLookupByLibrary.simpleMessage(
      "Preço e comissão vêm do catálogo. Dá para mudar só neste registro.",
    ),
    "catalogItems": MessageLookupByLibrary.simpleMessage("Catálogo"),
    "catalogMostUsed": MessageLookupByLibrary.simpleMessage("Mais usados"),
    "catalogWithoutCommission": MessageLookupByLibrary.simpleMessage(
      "Sem comissão",
    ),
    "changePassword": MessageLookupByLibrary.simpleMessage("Alterar Senha"),
    "checklistBuildCatalog": MessageLookupByLibrary.simpleMessage(
      "Montar seu catálogo",
    ),
    "checklistFinished": MessageLookupByLibrary.simpleMessage(
      "Pronto. Daqui em diante é só registrar.",
    ),
    "checklistFirstService": MessageLookupByLibrary.simpleMessage(
      "Registrar o 1º serviço",
    ),
    "checklistMarkReceived": MessageLookupByLibrary.simpleMessage(
      "Marcar um serviço como recebido",
    ),
    "checklistProgress": m14,
    "checklistSeeSummary": MessageLookupByLibrary.simpleMessage(
      "Ver o resumo do seu mês",
    ),
    "checklistThreeServices": MessageLookupByLibrary.simpleMessage(
      "Registrar 3 serviços seguidos",
    ),
    "checklistTitle": MessageLookupByLibrary.simpleMessage(
      "Deixe o Kazi do seu jeito",
    ),
    "clear": MessageLookupByLibrary.simpleMessage("Limpar"),
    "clearAll": MessageLookupByLibrary.simpleMessage("Limpar tudo"),
    "client": MessageLookupByLibrary.simpleMessage("Cliente"),
    "clientFormHint": MessageLookupByLibrary.simpleMessage(
      "Opcional. Serve para o histórico e o resumo por cliente.",
    ),
    "clientNamesake": m15,
    "clientNamesakeLastService": m16,
    "clientNamesakePlain": m17,
    "clientSameDocument": m18,
    "clientSameDocumentArchived": m19,
    "clientSince": m20,
    "clientSinceLabel": MessageLookupByLibrary.simpleMessage("Cliente desde"),
    "clients": MessageLookupByLibrary.simpleMessage("Clientes"),
    "clientsEmptyExplained": MessageLookupByLibrary.simpleMessage(
      "Seus clientes aparecem aqui conforme você registra serviços. Você também pode adicionar um agora.",
    ),
    "clipperCut": MessageLookupByLibrary.simpleMessage("Corte na máquina"),
    "close": MessageLookupByLibrary.simpleMessage("Fechar"),
    "color": MessageLookupByLibrary.simpleMessage("Cor"),
    "colorSwipeAll": MessageLookupByLibrary.simpleMessage(
      "Cor · deslize para ver todas",
    ),
    "commission": MessageLookupByLibrary.simpleMessage("Comissão"),
    "commissionGapsBody": MessageLookupByLibrary.simpleMessage(
      "Sem isso, eles entram no total gerado mas não no que você recebe.",
    ),
    "commissionGapsCta": MessageLookupByLibrary.simpleMessage(
      "Definir agora · 30 seg",
    ),
    "commissionGapsTitle": m21,
    "commissionOfGross": m22,
    "commissionPercent": m23,
    "commissionPercentage": MessageLookupByLibrary.simpleMessage(
      "Porcentagem da comissão",
    ),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirmar"),
    "confirmAction": MessageLookupByLibrary.simpleMessage("Confirmar Ação"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage("Confirme a Senha"),
    "contact": MessageLookupByLibrary.simpleMessage("Contato"),
    "contactEmail": MessageLookupByLibrary.simpleMessage(
      "guimaraeslucas242@gmail.com",
    ),
    "contactOptionsTitle": MessageLookupByLibrary.simpleMessage(
      "Entrar em contato",
    ),
    "continueAction": MessageLookupByLibrary.simpleMessage("Continuar"),
    "continueWithGoogle": MessageLookupByLibrary.simpleMessage(
      "Continuar com o Google",
    ),
    "create": MessageLookupByLibrary.simpleMessage("Criar"),
    "createAccount": MessageLookupByLibrary.simpleMessage("Crie uma Conta"),
    "createAndUse": MessageLookupByLibrary.simpleMessage("Criar e usar"),
    "createAnyway": MessageLookupByLibrary.simpleMessage("Criar assim mesmo"),
    "createInCatalog": m24,
    "currency": MessageLookupByLibrary.simpleMessage("Moeda"),
    "currencyAED": MessageLookupByLibrary.simpleMessage(
      "Dirham dos Emirados Árabes",
    ),
    "currencyAOA": MessageLookupByLibrary.simpleMessage("Kwanza angolano"),
    "currencyARS": MessageLookupByLibrary.simpleMessage("Peso argentino"),
    "currencyBOB": MessageLookupByLibrary.simpleMessage("Boliviano"),
    "currencyBRL": MessageLookupByLibrary.simpleMessage("Real brasileiro"),
    "currencyCAD": MessageLookupByLibrary.simpleMessage("Dólar canadense"),
    "currencyCHF": MessageLookupByLibrary.simpleMessage("Franco suíço"),
    "currencyCLP": MessageLookupByLibrary.simpleMessage("Peso chileno"),
    "currencyCNY": MessageLookupByLibrary.simpleMessage("Yuan chinês"),
    "currencyCOP": MessageLookupByLibrary.simpleMessage("Peso colombiano"),
    "currencyCRC": MessageLookupByLibrary.simpleMessage("Colón costa-riquenho"),
    "currencyCUP": MessageLookupByLibrary.simpleMessage("Peso cubano"),
    "currencyChangeNote": MessageLookupByLibrary.simpleMessage(
      "Trocar a moeda muda o símbolo e o formato. Os valores já registrados não são convertidos.",
    ),
    "currencyChangeNoteEmphasis": MessageLookupByLibrary.simpleMessage(
      "não são convertidos",
    ),
    "currencyDOP": MessageLookupByLibrary.simpleMessage("Peso dominicano"),
    "currencyETB": MessageLookupByLibrary.simpleMessage("Birr etíope"),
    "currencyEUR": MessageLookupByLibrary.simpleMessage("Euro"),
    "currencyGBP": MessageLookupByLibrary.simpleMessage("Libra esterlina"),
    "currencyGHS": MessageLookupByLibrary.simpleMessage("Cedi ganês"),
    "currencyGTQ": MessageLookupByLibrary.simpleMessage("Quetzal guatemalteco"),
    "currencyHNL": MessageLookupByLibrary.simpleMessage("Lempira hondurenha"),
    "currencyHTG": MessageLookupByLibrary.simpleMessage("Gourde haitiano"),
    "currencyINR": MessageLookupByLibrary.simpleMessage("Rúpia indiana"),
    "currencyJPY": MessageLookupByLibrary.simpleMessage("Iene japonês"),
    "currencyKES": MessageLookupByLibrary.simpleMessage("Xelim queniano"),
    "currencyKRW": MessageLookupByLibrary.simpleMessage("Won sul-coreano"),
    "currencyMAD": MessageLookupByLibrary.simpleMessage("Dirham marroquino"),
    "currencyMXN": MessageLookupByLibrary.simpleMessage("Peso mexicano"),
    "currencyMigrationApplying": MessageLookupByLibrary.simpleMessage(
      "Atualizando seus serviços…",
    ),
    "currencyMigrationChangeLater": MessageLookupByLibrary.simpleMessage(
      "Você pode alterar isso depois em Configurações.",
    ),
    "currencyMigrationDescription": MessageLookupByLibrary.simpleMessage(
      "O Kazi agora aceita várias moedas. Diga em qual seus serviços já cadastrados foram registrados para que seus totais fiquem certos.",
    ),
    "currencyMigrationServicesCount": m25,
    "currencyMigrationTitle": MessageLookupByLibrary.simpleMessage(
      "Em qual moeda você trabalha?",
    ),
    "currencyNGN": MessageLookupByLibrary.simpleMessage("Naira nigeriana"),
    "currencyNIO": MessageLookupByLibrary.simpleMessage("Córdoba nicaraguense"),
    "currencyPAB": MessageLookupByLibrary.simpleMessage("Balboa panamenho"),
    "currencyPEN": MessageLookupByLibrary.simpleMessage("Sol peruano"),
    "currencyPYG": MessageLookupByLibrary.simpleMessage("Guarani paraguaio"),
    "currencyRUB": MessageLookupByLibrary.simpleMessage("Rublo russo"),
    "currencySAR": MessageLookupByLibrary.simpleMessage("Rial saudita"),
    "currencySGD": MessageLookupByLibrary.simpleMessage("Dólar de Singapura"),
    "currencyTRY": MessageLookupByLibrary.simpleMessage("Lira turca"),
    "currencyUGX": MessageLookupByLibrary.simpleMessage("Xelim ugandense"),
    "currencyUSD": MessageLookupByLibrary.simpleMessage("Dólar americano"),
    "currencyUYU": MessageLookupByLibrary.simpleMessage("Peso uruguaio"),
    "currencyVES": MessageLookupByLibrary.simpleMessage("Bolívar venezuelano"),
    "currencyXAF": MessageLookupByLibrary.simpleMessage(
      "Franco CFA da África Central",
    ),
    "currencyXOF": MessageLookupByLibrary.simpleMessage(
      "Franco CFA da África Ocidental",
    ),
    "currencyZAR": MessageLookupByLibrary.simpleMessage("Rand sul-africano"),
    "currentCycle": MessageLookupByLibrary.simpleMessage("Ciclo atual"),
    "currentPassword": MessageLookupByLibrary.simpleMessage("Senha Atual"),
    "cycleClosesIn": m26,
    "cycleConfirmBody": MessageLookupByLibrary.simpleMessage(
      "Agora o Kazi agrupa seus ganhos pelo período em que você recebe. Estamos somando por mês, do dia 1 ao último. É assim mesmo?",
    ),
    "cycleConfirmNo": MessageLookupByLibrary.simpleMessage(
      "Recebo de outro jeito",
    ),
    "cycleConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "Uma pergunta só, e já volto ao seu trabalho",
    ),
    "cycleConfirmYes": MessageLookupByLibrary.simpleMessage("É assim mesmo"),
    "cycleGeneratedIn": m27,
    "darkMode": MessageLookupByLibrary.simpleMessage("Modo escuro"),
    "date": MessageLookupByLibrary.simpleMessage("Data"),
    "defaultCurrency": MessageLookupByLibrary.simpleMessage("Moeda padrão"),
    "defaultPrice": MessageLookupByLibrary.simpleMessage("Preço padrão"),
    "defaultValue": MessageLookupByLibrary.simpleMessage("Valor padrão"),
    "delete": MessageLookupByLibrary.simpleMessage("Deletar"),
    "deleteClientImpact": m28,
    "deleteForeverTitle": m29,
    "deleteNoServicesImpact": MessageLookupByLibrary.simpleMessage(
      "Não aparece em nenhum serviço, então nada do seu histórico muda. Esta ação não tem volta.",
    ),
    "deletePermanently": MessageLookupByLibrary.simpleMessage(
      "Excluir definitivamente",
    ),
    "deleteServiceImpact": MessageLookupByLibrary.simpleMessage(
      "O registro sai do histórico e dos totais. Esta ação não tem volta.",
    ),
    "description": MessageLookupByLibrary.simpleMessage("Descrição"),
    "details": MessageLookupByLibrary.simpleMessage("Detalhes"),
    "didntReceiveAnything": MessageLookupByLibrary.simpleMessage(
      "Não recebeu nada? ",
    ),
    "discountPercentage": MessageLookupByLibrary.simpleMessage(
      "Porcentagem do desconto",
    ),
    "document": MessageLookupByLibrary.simpleMessage("Documento"),
    "documentHint": MessageLookupByLibrary.simpleMessage(
      "CPF, CNPJ, RUC ou outro",
    ),
    "documentPrivacyHint": MessageLookupByLibrary.simpleMessage(
      "Só para você identificar a pessoa e emitir recibo. O Kazi não valida nem envia esse número para lugar nenhum.",
    ),
    "doesntHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Não possui uma conta? ",
    ),
    "earnedYou": MessageLookupByLibrary.simpleMessage("Gerou para você"),
    "earningsPerWeek": MessageLookupByLibrary.simpleMessage(
      "seu ganho por semana",
    ),
    "edit": MessageLookupByLibrary.simpleMessage("Editar"),
    "editService": MessageLookupByLibrary.simpleMessage("Editar Serviço"),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "employee": MessageLookupByLibrary.simpleMessage("Colaborador"),
    "employees": MessageLookupByLibrary.simpleMessage("Colaboradores"),
    "errorAccessDenied": MessageLookupByLibrary.simpleMessage("Acesso Negado"),
    "errorCantDeleteCatalogItem": MessageLookupByLibrary.simpleMessage(
      "Este serviço não pode ser removido do catálogo porque está em uso",
    ),
    "errorCredentialIsInvalid": MessageLookupByLibrary.simpleMessage(
      "A credencial é inválida",
    ),
    "errorDataIsSafe": MessageLookupByLibrary.simpleMessage(
      "Seus dados estão salvos — é só tentar de novo.",
    ),
    "errorEmailIsInvalid": MessageLookupByLibrary.simpleMessage(
      "O email é inválido ou mal formatado",
    ),
    "errorEmailWasNotFound": MessageLookupByLibrary.simpleMessage(
      "O email não foi encontrado, por favor, crie uma conta",
    ),
    "errorIncorrectEmailOrPassword": MessageLookupByLibrary.simpleMessage(
      "Senha ou email incorretos",
    ),
    "errorLaunchUrl": m30,
    "errorMethodNotAllowed": MessageLookupByLibrary.simpleMessage(
      "Método não permitido. Tente outra conta ou entre em contato com o suporte para obter ajuda.",
    ),
    "errorNotFound": MessageLookupByLibrary.simpleMessage(
      "Endereço não encontrado.",
    ),
    "errorThereIsAnotherAccount": MessageLookupByLibrary.simpleMessage(
      "Já existe uma conta com estas credenciais",
    ),
    "errorTimeout": MessageLookupByLibrary.simpleMessage(
      "O Servidor demorou a responder. Tente novamente mais tarde ou entre em contato conosco.",
    ),
    "errorToAddCatalogItem": MessageLookupByLibrary.simpleMessage(
      "Erro ao adicionar o serviço ao catálogo.",
    ),
    "errorToAddClient": MessageLookupByLibrary.simpleMessage(
      "Erro ao adicionar cliente.",
    ),
    "errorToAddService": MessageLookupByLibrary.simpleMessage(
      "Erro ao efetuar a adição do serviço.",
    ),
    "errorToArchiveCatalogItem": MessageLookupByLibrary.simpleMessage(
      "Erro ao arquivar o item do catálogo.",
    ),
    "errorToArchiveClient": MessageLookupByLibrary.simpleMessage(
      "Erro ao arquivar o cliente.",
    ),
    "errorToCountServices": MessageLookupByLibrary.simpleMessage(
      "Erro ao buscar quantidade de serviços.",
    ),
    "errorToDeleteCatalogItem": MessageLookupByLibrary.simpleMessage(
      "Erro ao remover o serviço do catálogo.",
    ),
    "errorToDeleteClient": MessageLookupByLibrary.simpleMessage(
      "Erro ao deletar cliente.",
    ),
    "errorToDeleteService": MessageLookupByLibrary.simpleMessage(
      "Erro ao efetuar a deleção do serviço.",
    ),
    "errorToGetCatalogItems": MessageLookupByLibrary.simpleMessage(
      "Erro ao buscar seu catálogo.",
    ),
    "errorToGetClients": MessageLookupByLibrary.simpleMessage(
      "Erro ao buscar clientes.",
    ),
    "errorToGetServices": MessageLookupByLibrary.simpleMessage(
      "Erro ao buscar os serviços.",
    ),
    "errorToGetUserSettings": MessageLookupByLibrary.simpleMessage(
      "Não conseguimos carregar suas configurações.",
    ),
    "errorToMarkReceived": MessageLookupByLibrary.simpleMessage(
      "Erro ao marcar os serviços como recebidos",
    ),
    "errorToMigrateCurrency": MessageLookupByLibrary.simpleMessage(
      "Não conseguimos atualizar seus serviços. Tente novamente.",
    ),
    "errorToOpenApp": MessageLookupByLibrary.simpleMessage(
      "Não foi possível abrir o aplicativo.",
    ),
    "errorToResetPassword": MessageLookupByLibrary.simpleMessage(
      "Erro ao redefinir senha.",
    ),
    "errorToRestoreCatalogItem": MessageLookupByLibrary.simpleMessage(
      "Erro ao restaurar o item do catálogo.",
    ),
    "errorToRestoreClient": MessageLookupByLibrary.simpleMessage(
      "Erro ao restaurar o cliente.",
    ),
    "errorToSaveUserSettings": MessageLookupByLibrary.simpleMessage(
      "Não conseguimos salvar suas configurações.",
    ),
    "errorToSendEmail": MessageLookupByLibrary.simpleMessage(
      "Erro ao enviar email.",
    ),
    "errorToSignIn": MessageLookupByLibrary.simpleMessage(
      "Erro ao fazer login. Tente novamente mais tarde ou contate o suporte.",
    ),
    "errorToSignUp": MessageLookupByLibrary.simpleMessage(
      "Erro ao efetuar cadastro. Tente novamente mais tarde ou contate o suporte.",
    ),
    "errorToUpdateCatalogItem": MessageLookupByLibrary.simpleMessage(
      "Erro ao editar o serviço do catálogo.",
    ),
    "errorToUpdateClient": MessageLookupByLibrary.simpleMessage(
      "Erro ao atualizar cliente.",
    ),
    "errorToUpdateService": MessageLookupByLibrary.simpleMessage(
      "Erro ao efetuar a edição do serviço.",
    ),
    "errorToVerifyDocument": MessageLookupByLibrary.simpleMessage(
      "Não foi possível verificar se este documento já está cadastrado. Tente novamente.",
    ),
    "errorUnknowError": MessageLookupByLibrary.simpleMessage(
      "Ocorreu um erro desconhecido.",
    ),
    "errorUserHasBeenDisabled": MessageLookupByLibrary.simpleMessage(
      "Este usuário foi desabilitado. Entre em contato com o suporte para obter ajuda",
    ),
    "errorVerificationCodeIsInvalid": MessageLookupByLibrary.simpleMessage(
      "O código de verificação inserido é inválido",
    ),
    "errorVerificationIdIsInvalid": MessageLookupByLibrary.simpleMessage(
      "O Id de verificação inserido é inválido",
    ),
    "exit": MessageLookupByLibrary.simpleMessage("Sair"),
    "featureNoAds": MessageLookupByLibrary.simpleMessage("Sem anúncios"),
    "featureUnlimitedCatalog": MessageLookupByLibrary.simpleMessage(
      "Catálogo ilimitado",
    ),
    "featureUnlimitedClients": MessageLookupByLibrary.simpleMessage(
      "Clientes ilimitados",
    ),
    "featureUnlimitedServices": MessageLookupByLibrary.simpleMessage(
      "Serviços ilimitados",
    ),
    "field": MessageLookupByLibrary.simpleMessage("Campo"),
    "filteringFromTo": m31,
    "filteringLastMonth": MessageLookupByLibrary.simpleMessage(
      "Filtrando pelo mês passado",
    ),
    "filteringToday": MessageLookupByLibrary.simpleMessage(
      "Filtrando por hoje",
    ),
    "filters": MessageLookupByLibrary.simpleMessage("Filtros"),
    "finish": MessageLookupByLibrary.simpleMessage("Finalizar"),
    "forcedUpdateButton": MessageLookupByLibrary.simpleMessage(
      "Atualizar agora",
    ),
    "forcedUpdateMessage": MessageLookupByLibrary.simpleMessage(
      "Atualize para continuar — seus dados estão salvos e aparecem assim que o app abrir.",
    ),
    "forcedUpdateTitle": MessageLookupByLibrary.simpleMessage(
      "Esta versão do Kazi parou de funcionar",
    ),
    "forcedUpdateVersions": m32,
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Recuperar Senha"),
    "forgotPasswordConfirmation1": MessageLookupByLibrary.simpleMessage(
      "Nós enviamos um email para ",
    ),
    "forgotPasswordConfirmation2": MessageLookupByLibrary.simpleMessage(
      " para recuperar sua senha. Depois de receber o e-mail, siga o link fornecido para fazer login.",
    ),
    "forgotPasswordInfo": MessageLookupByLibrary.simpleMessage(
      "Informe seu email para receber o link para redefinir sua senha.",
    ),
    "forgotYourPassword": MessageLookupByLibrary.simpleMessage(
      "Esqueceu sua senha?",
    ),
    "fortnight": MessageLookupByLibrary.simpleMessage("15 dias"),
    "freeLimitAds": MessageLookupByLibrary.simpleMessage("Com anúncios"),
    "freeLimitCatalogItems": m33,
    "freeLimitClients": m34,
    "freeLimitServices": m35,
    "freePlan": MessageLookupByLibrary.simpleMessage("Grátis"),
    "freeToDelete": MessageLookupByLibrary.simpleMessage("livre"),
    "fromTo": m36,
    "generated": MessageLookupByLibrary.simpleMessage("Gerado"),
    "generatedFromAmount": m37,
    "generatedFromClients": m38,
    "generatedInPeriod": MessageLookupByLibrary.simpleMessage(
      "Gerado no período",
    ),
    "generatedSoFar": MessageLookupByLibrary.simpleMessage("Gerou até hoje"),
    "goPremium": MessageLookupByLibrary.simpleMessage("Seja Premium"),
    "googleSignIn": MessageLookupByLibrary.simpleMessage("Login com Google"),
    "hi": m39,
    "hintFabBody": MessageLookupByLibrary.simpleMessage(
      "Toda vez que terminar um atendimento, toque no K no centro da barra. Escolha o serviço, confirme e pronto.",
    ),
    "hintFabTitle": MessageLookupByLibrary.simpleMessage(
      "É por aqui que você registra",
    ),
    "hintFiltersBody": MessageLookupByLibrary.simpleMessage(
      "Com algum histórico, os filtros acham um cliente, um período ou um serviço.",
    ),
    "hintFiltersTitle": MessageLookupByLibrary.simpleMessage("Afine a lista"),
    "hintGotIt": MessageLookupByLibrary.simpleMessage("Entendi"),
    "hintReceivedBody": MessageLookupByLibrary.simpleMessage(
      "Marcar um serviço como recebido fecha o ciclo entre o que você gerou e o que recebeu.",
    ),
    "hintReceivedTitle": MessageLookupByLibrary.simpleMessage(
      "Marque quando o dinheiro cair",
    ),
    "hintSummaryBody": MessageLookupByLibrary.simpleMessage(
      "O resumo mostra o que você gerou, o que é seu e o que já recebeu.",
    ),
    "hintSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "Seu mês, em um lugar só",
    ),
    "history": MessageLookupByLibrary.simpleMessage("Histórico"),
    "home": MessageLookupByLibrary.simpleMessage("Início"),
    "howToUseClientEarningsBody": MessageLookupByLibrary.simpleMessage(
      "Abra um cliente e toque em \"Ver no resumo\" para saber quanto ele gerou e quanto você recebeu.",
    ),
    "howToUseClientEarningsTitle": MessageLookupByLibrary.simpleMessage(
      "Veja quanto cada cliente rende",
    ),
    "howToUseCloseCycleBody": MessageLookupByLibrary.simpleMessage(
      "No cabeçalho de Serviços, marque tudo que ainda está pendente como recebido em um só toque.",
    ),
    "howToUseCloseCycleTitle": MessageLookupByLibrary.simpleMessage(
      "Feche o período de uma vez",
    ),
    "howToUseKazi": MessageLookupByLibrary.simpleMessage("Como usar o Kazi"),
    "howToUseStartBody": MessageLookupByLibrary.simpleMessage(
      "O botão amarelo no centro da tela abre a tela para registrar um serviço.",
    ),
    "howToUseStartHere": MessageLookupByLibrary.simpleMessage(
      "Comece por aqui",
    ),
    "howToUseStartTitle": MessageLookupByLibrary.simpleMessage(
      "Registrar um serviço",
    ),
    "inUse": m40,
    "invalidIntNumber": MessageLookupByLibrary.simpleMessage(
      "Por favor, informe um número inteiro válido",
    ),
    "invalidNumber": MessageLookupByLibrary.simpleMessage(
      "Por favor, informe um número válido",
    ),
    "invalidProperty": m41,
    "isEmpty": m42,
    "itemsCount": m43,
    "language": MessageLookupByLibrary.simpleMessage("Idioma"),
    "languageRestartNote": MessageLookupByLibrary.simpleMessage(
      "O app reinicia para aplicar o idioma. Nada do que você registrou se perde.",
    ),
    "lastMonth": MessageLookupByLibrary.simpleMessage("Mês Passado"),
    "lastServiceOn": m44,
    "lastServices": MessageLookupByLibrary.simpleMessage("Últimos serviços"),
    "leaveApp": MessageLookupByLibrary.simpleMessage(
      "Você quer mesmo sair do app?",
    ),
    "lightMode": MessageLookupByLibrary.simpleMessage("Modo claro"),
    "limitReachedCatalogTitle": MessageLookupByLibrary.simpleMessage(
      "Você atingiu o limite do seu catálogo",
    ),
    "limitReachedClientsTitle": MessageLookupByLibrary.simpleMessage(
      "Você atingiu o limite de clientes",
    ),
    "limitReachedServicesTitle": MessageLookupByLibrary.simpleMessage(
      "Você atingiu o limite de serviços do mês",
    ),
    "limitReachedSubtitle": MessageLookupByLibrary.simpleMessage(
      "Seja Premium para continuar adicionando sem limites.",
    ),
    "list": MessageLookupByLibrary.simpleMessage("Lista"),
    "loadMore": MessageLookupByLibrary.simpleMessage("Carregar mais"),
    "loading": MessageLookupByLibrary.simpleMessage("Carregando..."),
    "loginHeadline": MessageLookupByLibrary.simpleMessage(
      "Seu trabalho, com clareza.",
    ),
    "loginLegal": m45,
    "loginSubtitle": MessageLookupByLibrary.simpleMessage(
      "Entre para ver quanto você gera e quanto recebe.",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("Sair"),
    "logoutConfirmation": MessageLookupByLibrary.simpleMessage(
      "Você realmente gostaria de sair?",
    ),
    "managePlan": MessageLookupByLibrary.simpleMessage("Gerenciar plano"),
    "markAsReceived": MessageLookupByLibrary.simpleMessage(
      "Marcar como recebido",
    ),
    "markListedReceived": m46,
    "markListedReceivedBody": m47,
    "markListedReceivedConfirm": m48,
    "markListedReceivedUntouched": m49,
    "markReceived": MessageLookupByLibrary.simpleMessage("Marcar recebido"),
    "markedAsReceived": MessageLookupByLibrary.simpleMessage(
      "Marcados como recebidos",
    ),
    "menu": MessageLookupByLibrary.simpleMessage("Menu"),
    "month": MessageLookupByLibrary.simpleMessage("Mês"),
    "mostGets": MessageLookupByLibrary.simpleMessage("Mais faz"),
    "myWork": MessageLookupByLibrary.simpleMessage("Meu trabalho"),
    "name": MessageLookupByLibrary.simpleMessage("Nome"),
    "newCatalogItem": MessageLookupByLibrary.simpleMessage("Novo serviço"),
    "newClient": MessageLookupByLibrary.simpleMessage("Novo Cliente"),
    "newPassword": MessageLookupByLibrary.simpleMessage("Nova Senha"),
    "newService": MessageLookupByLibrary.simpleMessage("Novo Serviço"),
    "newShort": MessageLookupByLibrary.simpleMessage("+ Novo"),
    "next": MessageLookupByLibrary.simpleMessage("Próximo"),
    "noCatalogItems": MessageLookupByLibrary.simpleMessage(
      "Seu catálogo está vazio. Toque no botão acima para adicionar o primeiro serviço.",
    ),
    "noCatalogItemsDescription": MessageLookupByLibrary.simpleMessage(
      "Cadastre o que você faz e por quanto.",
    ),
    "noClientsDescription": MessageLookupByLibrary.simpleMessage(
      "Eles são criados sozinhos conforme você registra serviços. Ou cadastre a primeira agora.",
    ),
    "noClientsFound": MessageLookupByLibrary.simpleMessage(
      "Nenhum cliente encontrado",
    ),
    "noColor": MessageLookupByLibrary.simpleMessage("Sem cor"),
    "noResults": MessageLookupByLibrary.simpleMessage("Sem resultados"),
    "noServiceForThisClient": MessageLookupByLibrary.simpleMessage(
      "Nenhum serviço registrado para esta pessoa ainda.",
    ),
    "noServiceYet": MessageLookupByLibrary.simpleMessage(
      "Nenhum serviço ainda",
    ),
    "noServices": MessageLookupByLibrary.simpleMessage("Nenhum serviço"),
    "noServicesForFilters": MessageLookupByLibrary.simpleMessage(
      "Nenhum serviço corresponde a estes filtros.",
    ),
    "noServicesFound": MessageLookupByLibrary.simpleMessage(
      "Nenhum serviço encontrado.",
    ),
    "noServicesToday": MessageLookupByLibrary.simpleMessage(
      "Nenhum serviço registrado hoje",
    ),
    "noServicesTodayDescription": MessageLookupByLibrary.simpleMessage(
      "Registre um e ele aparece aqui.",
    ),
    "noServicesYet": MessageLookupByLibrary.simpleMessage(
      "Nenhum serviço realizado",
    ),
    "notReceived": MessageLookupByLibrary.simpleMessage("Ainda não recebido"),
    "nothingFoundFor": m50,
    "nothingFoundForDescription": MessageLookupByLibrary.simpleMessage(
      "Nenhum serviço, cliente ou item do catálogo com esse nome.",
    ),
    "nothingFoundInCatalog": MessageLookupByLibrary.simpleMessage(
      "Nenhum item do catálogo com esse nome.",
    ),
    "numberBiggerThan100": MessageLookupByLibrary.simpleMessage(
      "Por favor, informe um número menor ou igual a 100",
    ),
    "numberLesserThanZero": MessageLookupByLibrary.simpleMessage(
      "Por favor, informe um número maior ou igual a zero",
    ),
    "observation": MessageLookupByLibrary.simpleMessage("Observação"),
    "observationHint": MessageLookupByLibrary.simpleMessage(
      "Alergia, preferência, horário",
    ),
    "ofGross": m51,
    "optional": MessageLookupByLibrary.simpleMessage("opcional"),
    "optionalUpdateMessage": MessageLookupByLibrary.simpleMessage(
      "Uma nova versão do Kazi está disponível com melhorias. Deseja atualizar agora?",
    ),
    "optionalUpdateTitle": MessageLookupByLibrary.simpleMessage(
      "Atualização disponível",
    ),
    "or": MessageLookupByLibrary.simpleMessage("ou"),
    "orderAlphabetical": MessageLookupByLibrary.simpleMessage("Alfabétical"),
    "orderBy": MessageLookupByLibrary.simpleMessage("Ordernar por"),
    "orderDateAsc": MessageLookupByLibrary.simpleMessage(
      "Menos atual para mais atual",
    ),
    "orderDateDesc": MessageLookupByLibrary.simpleMessage(
      "Mais atual para menos atual",
    ),
    "orderLastService": MessageLookupByLibrary.simpleMessage("Último serviço"),
    "orderTopEarning": MessageLookupByLibrary.simpleMessage("Mais renderam"),
    "orderValueAsc": MessageLookupByLibrary.simpleMessage("Menor para maior"),
    "orderValueDesc": MessageLookupByLibrary.simpleMessage("Maior para menor"),
    "password": MessageLookupByLibrary.simpleMessage("Senha"),
    "paywallPricePerMonth": m52,
    "paywallRenewInfo": MessageLookupByLibrary.simpleMessage(
      "Renova automaticamente todo mês. Cancele quando quiser.",
    ),
    "paywallRestore": MessageLookupByLibrary.simpleMessage("Restaurar compra"),
    "paywallStartTrial": MessageLookupByLibrary.simpleMessage(
      "Iniciar teste grátis de 7 dias",
    ),
    "paywallSubscribe": MessageLookupByLibrary.simpleMessage("Assinar"),
    "paywallSubtitle": MessageLookupByLibrary.simpleMessage(
      "Remova todos os limites e anúncios.",
    ),
    "paywallTitle": MessageLookupByLibrary.simpleMessage(
      "Desbloqueie o Kazi Premium",
    ),
    "paywallTrialThenPrice": m53,
    "pendingAmount": m54,
    "pendingReceipt": MessageLookupByLibrary.simpleMessage("Pendentes"),
    "period": MessageLookupByLibrary.simpleMessage("Período"),
    "periodYourEarnings": m55,
    "phone": MessageLookupByLibrary.simpleMessage("Telefone"),
    "phoneHint": MessageLookupByLibrary.simpleMessage("Para chamar depois"),
    "pickDate": MessageLookupByLibrary.simpleMessage("Escolher"),
    "pickDates": MessageLookupByLibrary.simpleMessage("Escolher datas"),
    "planComparisonTitle": MessageLookupByLibrary.simpleMessage(
      "Grátis vs Premium",
    ),
    "preferences": MessageLookupByLibrary.simpleMessage("Preferências"),
    "premiumPlan": MessageLookupByLibrary.simpleMessage("Premium"),
    "premiumUnlimited": MessageLookupByLibrary.simpleMessage(
      "Tudo ilimitado, sem anúncios",
    ),
    "presetCleaning": MessageLookupByLibrary.simpleMessage(
      "Limpeza e diarista",
    ),
    "presetCleaningDeepClean": MessageLookupByLibrary.simpleMessage(
      "Faxina pesada",
    ),
    "presetCleaningFullDay": MessageLookupByLibrary.simpleMessage("Diária"),
    "presetCleaningHalfDay": MessageLookupByLibrary.simpleMessage(
      "Meia diária",
    ),
    "presetCleaningIroning": MessageLookupByLibrary.simpleMessage(
      "Passar roupa (por hora)",
    ),
    "presetCleaningPostConstruction": MessageLookupByLibrary.simpleMessage(
      "Pós-obra",
    ),
    "presetDesign": MessageLookupByLibrary.simpleMessage("Design e criação"),
    "presetDesignBrandIdentity": MessageLookupByLibrary.simpleMessage(
      "Identidade visual",
    ),
    "presetDesignHourly": MessageLookupByLibrary.simpleMessage("Hora avulsa"),
    "presetDesignLandingPage": MessageLookupByLibrary.simpleMessage(
      "Landing page",
    ),
    "presetDesignLogo": MessageLookupByLibrary.simpleMessage("Logo"),
    "presetDesignSocialPost": MessageLookupByLibrary.simpleMessage(
      "Post para redes",
    ),
    "presetEsthetics": MessageLookupByLibrary.simpleMessage(
      "Estética e sobrancelhas",
    ),
    "presetEstheticsBrowDesign": MessageLookupByLibrary.simpleMessage(
      "Design de sobrancelha",
    ),
    "presetEstheticsBrowHenna": MessageLookupByLibrary.simpleMessage(
      "Design com henna",
    ),
    "presetEstheticsFacialCleansing": MessageLookupByLibrary.simpleMessage(
      "Limpeza de pele",
    ),
    "presetEstheticsFullLegWax": MessageLookupByLibrary.simpleMessage(
      "Depilação perna inteira",
    ),
    "presetEstheticsLashExtensions": MessageLookupByLibrary.simpleMessage(
      "Extensão de cílios",
    ),
    "presetEstheticsPeeling": MessageLookupByLibrary.simpleMessage("Peeling"),
    "presetEstheticsUnderarmWax": MessageLookupByLibrary.simpleMessage(
      "Depilação axila",
    ),
    "presetEstheticsUpperLipWax": MessageLookupByLibrary.simpleMessage(
      "Depilação buço",
    ),
    "presetHair": MessageLookupByLibrary.simpleMessage("Cabelo e barbearia"),
    "presetHairBeard": MessageLookupByLibrary.simpleMessage("Barba"),
    "presetHairBlowDry": MessageLookupByLibrary.simpleMessage("Escova"),
    "presetHairColoring": MessageLookupByLibrary.simpleMessage("Coloração"),
    "presetHairConditioning": MessageLookupByLibrary.simpleMessage(
      "Hidratação",
    ),
    "presetHairCutAndBeard": MessageLookupByLibrary.simpleMessage(
      "Corte + barba",
    ),
    "presetHairHighlights": MessageLookupByLibrary.simpleMessage(
      "Luzes / mechas",
    ),
    "presetHairMensCut": MessageLookupByLibrary.simpleMessage(
      "Corte masculino",
    ),
    "presetHairWomensCut": MessageLookupByLibrary.simpleMessage(
      "Corte feminino",
    ),
    "presetHandyman": MessageLookupByLibrary.simpleMessage(
      "Montagem e reparos",
    ),
    "presetHandymanBed": MessageLookupByLibrary.simpleMessage(
      "Montagem de cama",
    ),
    "presetHandymanCallout": MessageLookupByLibrary.simpleMessage(
      "Visita técnica",
    ),
    "presetHandymanShelf": MessageLookupByLibrary.simpleMessage(
      "Prateleira / suporte",
    ),
    "presetHandymanTvMount": MessageLookupByLibrary.simpleMessage(
      "Instalação de TV",
    ),
    "presetHandymanWardrobe": MessageLookupByLibrary.simpleMessage(
      "Montagem de guarda-roupa",
    ),
    "presetMakeup": MessageLookupByLibrary.simpleMessage("Maquiagem"),
    "presetMakeupBride": MessageLookupByLibrary.simpleMessage("Noiva"),
    "presetMakeupBridesmaid": MessageLookupByLibrary.simpleMessage("Madrinha"),
    "presetMakeupClass": MessageLookupByLibrary.simpleMessage(
      "Aula de automaquiagem",
    ),
    "presetMakeupGraduation": MessageLookupByLibrary.simpleMessage("Formatura"),
    "presetMakeupSocial": MessageLookupByLibrary.simpleMessage(
      "Maquiagem social",
    ),
    "presetManicure": MessageLookupByLibrary.simpleMessage(
      "Manicure e pedicure",
    ),
    "presetManicureExtensionRemoval": MessageLookupByLibrary.simpleMessage(
      "Remoção de alongamento",
    ),
    "presetManicureFootSpa": MessageLookupByLibrary.simpleMessage(
      "Spa dos pés",
    ),
    "presetManicureGelExtension": MessageLookupByLibrary.simpleMessage(
      "Alongamento em gel",
    ),
    "presetManicureGelRefill": MessageLookupByLibrary.simpleMessage(
      "Manutenção de gel",
    ),
    "presetManicureHandsAndFeet": MessageLookupByLibrary.simpleMessage(
      "Mão e pé",
    ),
    "presetManicurePolishFeet": MessageLookupByLibrary.simpleMessage(
      "Esmaltação pés",
    ),
    "presetManicurePolishHands": MessageLookupByLibrary.simpleMessage(
      "Esmaltação mãos",
    ),
    "presetManicureStrengthening": MessageLookupByLibrary.simpleMessage(
      "Blindagem",
    ),
    "presetMassage": MessageLookupByLibrary.simpleMessage(
      "Massagem e bem-estar",
    ),
    "presetMassageContouring": MessageLookupByLibrary.simpleMessage(
      "Modeladora",
    ),
    "presetMassageHotStone": MessageLookupByLibrary.simpleMessage(
      "Pedras quentes",
    ),
    "presetMassageLymphatic": MessageLookupByLibrary.simpleMessage(
      "Drenagem linfática",
    ),
    "presetMassagePackTen": MessageLookupByLibrary.simpleMessage(
      "Pacote 10 sessões",
    ),
    "presetMassageRelaxing": MessageLookupByLibrary.simpleMessage(
      "Relaxante 60 min",
    ),
    "presetOther": MessageLookupByLibrary.simpleMessage("Outra profissão"),
    "presetPersonalAssessment": MessageLookupByLibrary.simpleMessage(
      "Avaliação física",
    ),
    "presetPersonalMonthlyPlan": MessageLookupByLibrary.simpleMessage(
      "Mensal 3× por semana",
    ),
    "presetPersonalOnlineProgram": MessageLookupByLibrary.simpleMessage(
      "Treino online",
    ),
    "presetPersonalPackEight": MessageLookupByLibrary.simpleMessage(
      "Pacote 8 aulas",
    ),
    "presetPersonalSingleSession": MessageLookupByLibrary.simpleMessage(
      "Aula avulsa",
    ),
    "presetPersonalTrainer": MessageLookupByLibrary.simpleMessage(
      "Personal e educação física",
    ),
    "pricayPoliceLinks": MessageLookupByLibrary.simpleMessage(
      "Este Serviço pode conter links para outros sites. Se você clicar em um link de terceiros, será direcionado para esse site. Observe que esses sites externos não são operados por mim. Portanto, aconselho fortemente que você revise a Política de Privacidade desses sites. Não tenho controle e não assumo nenhuma responsabilidade pelo conteúdo, políticas de privacidade ou práticas de sites ou serviços de terceiros.",
    ),
    "pricayPoliceLinksTitle": MessageLookupByLibrary.simpleMessage(
      "Links para outros sites",
    ),
    "priceChangeNote": m56,
    "privacy": MessageLookupByLibrary.simpleMessage("Privacidade"),
    "privacyPolice": MessageLookupByLibrary.simpleMessage(
      "Política de Privacidade",
    ),
    "privacyPoliceAnalytics": MessageLookupByLibrary.simpleMessage(
      "Para entender onde o aplicativo atrapalha e por que as pessoas deixam de usá-lo, eu coleto eventos de uso: quais telas você abre, quais ações você conclui, quais erros aparecem para você e atributos técnicos como versão do app, idioma e tipo de aparelho.\nEsses eventos descrevem comportamento, nunca conteúdo. Eles jamais carregam os valores que você registra, os nomes dos seus clientes, seu endereço de e-mail ou qualquer texto livre que você digite — o aplicativo remove isso antes de enviar qualquer coisa.\nA base legal é o meu legítimo interesse em melhorar o Serviço, e você pode se opor a qualquer momento em Menu > Privacidade.\nOperadores: Google Firebase Analytics (Google LLC) e PostHog (PostHog, Inc.), cujos dados deste aplicativo ficam hospedados na União Europeia.",
    ),
    "privacyPoliceAnalyticsTitle": MessageLookupByLibrary.simpleMessage(
      "Análise de uso",
    ),
    "privacyPoliceChanges": MessageLookupByLibrary.simpleMessage(
      "Posso atualizar nossa Política de Privacidade de tempos em tempos. Assim, você é aconselhado a revisar esta página periodicamente para verificar alterações. Notificarei quaisquer mudanças publicando a nova Política de Privacidade nesta página.\nEsta política entra em vigor em 2026-08-20.",
    ),
    "privacyPoliceChangesTitle": MessageLookupByLibrary.simpleMessage(
      "Mudanças nesta Política de Privacidade",
    ),
    "privacyPoliceChildren": MessageLookupByLibrary.simpleMessage(
      "Esses Serviços não se dirigem a menores de 13 anos. Não coleto intencionalmente informações de identificação pessoal de crianças menores de 13 anos. No caso de eu descobrir que uma criança menor de 13 anos me forneceu informações pessoais, eu as excluo imediatamente de nossos servidores. Se você é pai ou responsável e está ciente de que seu filho nos forneceu informações pessoais, entre em contato comigo para que eu possa tomar as medidas necessárias.",
    ),
    "privacyPoliceChildrenTitle": MessageLookupByLibrary.simpleMessage(
      "Privacidade das crianças",
    ),
    "privacyPoliceContact": MessageLookupByLibrary.simpleMessage(
      "Se tiver alguma dúvida ou sugestão sobre a minha Política de Privacidade, não hesite em contactar-me em ",
    ),
    "privacyPoliceContactTitle": MessageLookupByLibrary.simpleMessage(
      "Contate-nos",
    ),
    "privacyPoliceCookies": MessageLookupByLibrary.simpleMessage(
      "Cookies são arquivos com uma pequena quantidade de dados que são comumente usados como identificadores únicos anônimos. Estes são enviados para o seu navegador a partir dos sites que você visita e são armazenados na memória interna do seu dispositivo.\nEste Serviço não usa esses “cookies” explicitamente. No entanto, o aplicativo pode usar código e bibliotecas de terceiros que usam “cookies” para coletar informações e melhorar seus serviços. Você tem a opção de aceitar ou recusar esses cookies e saber quando um cookie está sendo enviado ao seu dispositivo. Se você optar por recusar nossos cookies, talvez não consiga usar algumas partes deste Serviço.",
    ),
    "privacyPoliceCookiesTitle": MessageLookupByLibrary.simpleMessage(
      "Cookies",
    ),
    "privacyPoliceEnd": MessageLookupByLibrary.simpleMessage(
      "Esta página de política de privacidade foi criada em privacypolicytemplate.net e modificada/gerada pelo App Privacy Policy Generator.",
    ),
    "privacyPoliceInformation": MessageLookupByLibrary.simpleMessage(
      "Para uma melhor experiência, ao usar nosso Serviço, posso exigir que você nos forneça certas informações de identificação pessoal, incluindo, entre outras, nome e endereço de e-mail, que vêm da conta Google com que você entra. Essas informações, junto com os serviços, clientes e configurações que você registra, ficam guardadas na sua conta para estarem disponíveis em qualquer aparelho em que você entrar.\nO aplicativo também usa serviços de terceiros que podem coletar informações usadas para identificá-lo.\nLink para a política de privacidade de provedores de serviços terceirizados usados pelo app:\n",
    ),
    "privacyPoliceInformation1": MessageLookupByLibrary.simpleMessage(
      "Serviços do Google Play",
    ),
    "privacyPoliceInformation2": MessageLookupByLibrary.simpleMessage("AdMob"),
    "privacyPoliceInformation3": MessageLookupByLibrary.simpleMessage(
      "Google Analytics",
    ),
    "privacyPoliceInformation4": MessageLookupByLibrary.simpleMessage(
      "Firebase Crashlytics",
    ),
    "privacyPoliceInformation5": MessageLookupByLibrary.simpleMessage(
      "RevenueCat",
    ),
    "privacyPoliceInformation6": MessageLookupByLibrary.simpleMessage(
      "PostHog",
    ),
    "privacyPoliceInformationTitle": MessageLookupByLibrary.simpleMessage(
      "Coleta e uso de informações",
    ),
    "privacyPoliceLogData": MessageLookupByLibrary.simpleMessage(
      "Quero informar que sempre que você usa meu Serviço, em caso de erro no aplicativo, eu coleto dados e informações (através de produtos de terceiros) em seu telefone chamado Log Data. Esses dados de registro podem incluir informações como endereço de protocolo de Internet (\"IP\") do dispositivo, nome do dispositivo, versão do sistema operacional, configuração do aplicativo ao utilizar meu serviço, hora e data de uso do serviço e outras estatísticas.",
    ),
    "privacyPoliceLogDataTitle": MessageLookupByLibrary.simpleMessage(
      "Dados de registro",
    ),
    "privacyPoliceReplay": MessageLookupByLibrary.simpleMessage(
      "Com a sua permissão explícita, e somente com ela, o aplicativo pode gravar uma sessão como uma sequência de capturas de tela, para que eu veja onde as pessoas travam.\nTodo texto e toda imagem são mascarados no seu aparelho antes de qualquer envio. O que fica armazenado mostra o layout, os toques e a rolagem — não o que está escrito na tela.\nA gravação nunca vem ligada por padrão. Você é perguntado uma vez e pode retirar a permissão quando quiser em Menu > Privacidade, o que a interrompe imediatamente. Nem toda sessão é gravada: uma amostra é, mais as sessões em que o aplicativo detecta que algo deu errado.",
    ),
    "privacyPoliceReplayTitle": MessageLookupByLibrary.simpleMessage(
      "Gravação de sessão",
    ),
    "privacyPoliceRetention": MessageLookupByLibrary.simpleMessage(
      "Seus serviços, clientes e configurações são mantidos enquanto a sua conta existir e são excluídos quando você pede a exclusão da conta.\nEventos de uso e gravações de sessão são mantidos por um período limitado pelos provedores de análise e excluídos automaticamente depois disso. Relatórios de falha são mantidos por até 90 dias.",
    ),
    "privacyPoliceRetentionTitle": MessageLookupByLibrary.simpleMessage(
      "Retenção de dados",
    ),
    "privacyPoliceRights": MessageLookupByLibrary.simpleMessage(
      "Pela Lei Geral de Proteção de Dados (LGPD, Lei 13.709/2018) e legislações equivalentes, você tem direito a confirmar que seus dados são tratados, acessá-los, corrigi-los, pedir sua anonimização, bloqueio ou eliminação, pedir portabilidade, saber com quem são compartilhados e se opor ao tratamento baseado em legítimo interesse.\nAs duas chaves em Menu > Privacidade permitem exercer o direito de oposição direto no aplicativo, sem pedir a ninguém. Para qualquer outra coisa, escreva para o endereço abaixo que eu respondo.",
    ),
    "privacyPoliceRightsTitle": MessageLookupByLibrary.simpleMessage(
      "Seus direitos",
    ),
    "privacyPoliceSecurity": MessageLookupByLibrary.simpleMessage(
      "Eu valorizo sua confiança em nos fornecer suas informações pessoais, portanto, estamos nos esforçando para usar meios comercialmente aceitáveis de protegê-las. Mas lembre-se que nenhum método de transmissão pela internet, ou método de armazenamento eletrônico é 100% seguro e confiável, e não posso garantir sua segurança absoluta.",
    ),
    "privacyPoliceSecurityTitle": MessageLookupByLibrary.simpleMessage(
      "Segurança",
    ),
    "privacyPoliceServices": MessageLookupByLibrary.simpleMessage(
      "Posso contratar empresas e indivíduos terceirizados pelos seguintes motivos:\n\nPara facilitar nosso Serviço;\nPara fornecer o Serviço em nosso nome;\nPara realizar serviços relacionados ao Serviço; ou\nPara nos ajudar a analisar como nosso Serviço é usado.\n\nDesejo informar aos usuários deste Serviço que esses terceiros têm acesso às suas Informações Pessoais. O motivo é realizar as tarefas atribuídas a eles em nosso nome. No entanto, eles são obrigados a não divulgar ou usar as informações para qualquer outra finalidade.",
    ),
    "privacyPoliceServicesTitle": MessageLookupByLibrary.simpleMessage(
      "Provedores de Serviço",
    ),
    "privacyPoliceStart": MessageLookupByLibrary.simpleMessage(
      "Lucas Guimarães criou o aplicativo Kazi como um aplicativo suportado por anúncios. Este SERVIÇO é fornecido pela Lucas Guimarães sem custos e destina-se a ser utilizado tal como está.\nEsta página é usada para informar os visitantes sobre minhas políticas de coleta, uso e divulgação de informações pessoais, caso alguém decida usar meu serviço.\nSe você optar por usar meu serviço, concorda com a coleta e o uso de informações relacionadas a esta política. As Informações Pessoais que eu coleto são usadas para fornecer e melhorar o Serviço. Não usarei ou compartilharei suas informações com ninguém, exceto conforme descrito nesta Política de Privacidade.\nOs termos usados nesta Política de Privacidade têm os mesmos significados que em nossos Termos e Condições, que podem ser acessados no Kazi, a menos que definido de outra forma nesta Política de Privacidade.",
    ),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Política de privacidade",
    ),
    "privacySessionRecording": MessageLookupByLibrary.simpleMessage(
      "Gravação de sessão",
    ),
    "privacySessionRecordingDescription": MessageLookupByLibrary.simpleMessage(
      "Grava um replay mascarado de algumas sessões. Todo texto e imagem ficam ocultos.",
    ),
    "privacyUsageData": MessageLookupByLibrary.simpleMessage(
      "Ajudar a melhorar o Kazi",
    ),
    "privacyUsageDataDescription": MessageLookupByLibrary.simpleMessage(
      "Envia eventos de uso anônimos para descobrirmos o que não está funcionando. Nunca seus valores nem seus clientes.",
    ),
    "profile": MessageLookupByLibrary.simpleMessage("Profile"),
    "quantity": MessageLookupByLibrary.simpleMessage("Quantidade"),
    "quantityHint": MessageLookupByLibrary.simpleMessage(
      "Número de vezes que o serviço foi prestado",
    ),
    "rateApp": MessageLookupByLibrary.simpleMessage("Avaliar o app"),
    "ratesUnavailable": MessageLookupByLibrary.simpleMessage(
      "Cotações indisponíveis",
    ),
    "ratesUnavailableDescription": MessageLookupByLibrary.simpleMessage(
      "Conecte-se à internet para ver seus totais convertidos.",
    ),
    "received": MessageLookupByLibrary.simpleMessage("Recebido"),
    "receivedOn": m57,
    "receivedPlural": MessageLookupByLibrary.simpleMessage("Recebidos"),
    "registerService": MessageLookupByLibrary.simpleMessage(
      "Registrar serviço",
    ),
    "removeFilters": MessageLookupByLibrary.simpleMessage("Remover filtros"),
    "replayConsentAccept": MessageLookupByLibrary.simpleMessage("Pode gravar"),
    "replayConsentBody": MessageLookupByLibrary.simpleMessage(
      "Gravamos os toques e as telas para descobrir onde o Kazi atrapalha. Valores, nomes de clientes e qualquer texto digitado ficam ocultos na gravação.\n\nVocê pode desligar quando quiser, em Menu › Gravação de sessão.",
    ),
    "replayConsentDecline": MessageLookupByLibrary.simpleMessage("Agora não"),
    "replayConsentLearnMore": MessageLookupByLibrary.simpleMessage(
      "Como isso é usado",
    ),
    "replayConsentTitle": MessageLookupByLibrary.simpleMessage(
      "Podemos gravar como você usa o app?",
    ),
    "requiredProperty": m58,
    "resendEmail": MessageLookupByLibrary.simpleMessage("Reenviar Email"),
    "resetedPassword": MessageLookupByLibrary.simpleMessage(
      "Senha redefinida com sucesso",
    ),
    "restore": MessageLookupByLibrary.simpleMessage("Restaurar"),
    "restoredSnackbar": m59,
    "role": MessageLookupByLibrary.simpleMessage("Função"),
    "save": MessageLookupByLibrary.simpleMessage("Salvar"),
    "saving": MessageLookupByLibrary.simpleMessage("Salvando…"),
    "search": MessageLookupByLibrary.simpleMessage("Busca"),
    "searchByName": MessageLookupByLibrary.simpleMessage("Buscar por nome"),
    "searchClientsHint": MessageLookupByLibrary.simpleMessage(
      "Buscar por nome",
    ),
    "searchIgnoresPeriod": MessageLookupByLibrary.simpleMessage(
      "A busca ignora o período: ela procura em tudo que você já registrou.",
    ),
    "searchServiceTypeHint": MessageLookupByLibrary.simpleMessage(
      "Buscar um tipo",
    ),
    "searchServicesFound": m60,
    "searchServicesHint": MessageLookupByLibrary.simpleMessage(
      "Tipo, cliente ou observação",
    ),
    "seeInList": MessageLookupByLibrary.simpleMessage("Ver na lista"),
    "seeInSummary": MessageLookupByLibrary.simpleMessage("Ver no resumo"),
    "seeNServices": m61,
    "seeSummaryOf": m62,
    "seeTheServices": m63,
    "selectCatalogItem": MessageLookupByLibrary.simpleMessage(
      "Selecione o serviço",
    ),
    "selectClient": MessageLookupByLibrary.simpleMessage("Selecione o cliente"),
    "selectCurrency": MessageLookupByLibrary.simpleMessage(
      "Selecione uma moeda",
    ),
    "sendEmail": MessageLookupByLibrary.simpleMessage("Enviar Email"),
    "service": MessageLookupByLibrary.simpleMessage("Serviço"),
    "serviceAdded": MessageLookupByLibrary.simpleMessage(
      "Serviço adicionado com sucesso",
    ),
    "serviceCatalog": MessageLookupByLibrary.simpleMessage(
      "Catálogo de serviços",
    ),
    "serviceCurrencyHint": MessageLookupByLibrary.simpleMessage(
      "Moeda em que o serviço foi cobrado",
    ),
    "serviceDeleted": MessageLookupByLibrary.simpleMessage(
      "Serviço deletado com sucesso",
    ),
    "serviceType": MessageLookupByLibrary.simpleMessage("Tipo de serviço"),
    "serviceUpdated": MessageLookupByLibrary.simpleMessage(
      "Serviço editado com sucesso",
    ),
    "serviceValue": MessageLookupByLibrary.simpleMessage("Valor do Serviço"),
    "services": MessageLookupByLibrary.simpleMessage("Serviços"),
    "servicesCount": m64,
    "settings": MessageLookupByLibrary.simpleMessage("Configurações"),
    "setupCatalogAddAnother": MessageLookupByLibrary.simpleMessage(
      "Adicionar outro serviço",
    ),
    "setupCatalogBlankPrice": MessageLookupByLibrary.simpleMessage(
      "Não sabe o preço? Deixe em branco — o Kazi pergunta na hora de registrar.",
    ),
    "setupCatalogContinueWith": m65,
    "setupCatalogDuplicate": MessageLookupByLibrary.simpleMessage(
      "Você já tem um serviço com esse nome.",
    ),
    "setupCatalogSubtitle": MessageLookupByLibrary.simpleMessage(
      "Desmarque o que não fizer e toque no valor para colocar o seu preço.",
    ),
    "setupCatalogTitle": MessageLookupByLibrary.simpleMessage(
      "Estes são os serviços que você faz?",
    ),
    "setupCatalogTypedSubtitle": MessageLookupByLibrary.simpleMessage(
      "Comece pelo mais comum. Depois dá para incluir quantos quiser.",
    ),
    "setupCatalogTypedTitle": MessageLookupByLibrary.simpleMessage(
      "Quais serviços você faz?",
    ),
    "setupCatalogYourPrices": MessageLookupByLibrary.simpleMessage(
      "Seus preços",
    ),
    "setupCommissionPerItem": MessageLookupByLibrary.simpleMessage(
      "Toque em um serviço para mudar só ele.",
    ),
    "setupCommissionSubtitle": MessageLookupByLibrary.simpleMessage(
      "É a comissão do salão. Se trabalha por conta, escolha 100%.",
    ),
    "setupCommissionTitle": MessageLookupByLibrary.simpleMessage(
      "Quanto fica com você em cada serviço?",
    ),
    "setupContinue": MessageLookupByLibrary.simpleMessage("Continuar"),
    "setupCycleMonthlyDetail": m66,
    "setupCycleSubtitle": MessageLookupByLibrary.simpleMessage(
      "O Kazi soma seus ganhos dentro desse período.",
    ),
    "setupCycleTitle": MessageLookupByLibrary.simpleMessage(
      "Quando você recebe?",
    ),
    "setupEmployed": MessageLookupByLibrary.simpleMessage(
      "Trabalho para um salão ou empresa",
    ),
    "setupEmployedDetail": MessageLookupByLibrary.simpleMessage(
      "recebo comissão",
    ),
    "setupExitMessage": MessageLookupByLibrary.simpleMessage(
      "O que você respondeu fica salvo. Dá para retomar pela tela inicial.",
    ),
    "setupExitTitle": MessageLookupByLibrary.simpleMessage(
      "Sair da configuração?",
    ),
    "setupFirstServiceOtherDay": MessageLookupByLibrary.simpleMessage(
      "Outro dia",
    ),
    "setupFirstServicePastCycle": MessageLookupByLibrary.simpleMessage(
      "Esse serviço entra no ciclo passado.",
    ),
    "setupFirstServiceRegister": MessageLookupByLibrary.simpleMessage(
      "Registrar",
    ),
    "setupFirstServiceSkip": MessageLookupByLibrary.simpleMessage(
      "Ainda não atendi — faço isso depois",
    ),
    "setupFirstServiceSubtitle": MessageLookupByLibrary.simpleMessage(
      "Pode ser o de hoje mesmo. Leva 10 segundos.",
    ),
    "setupFirstServiceTitle": MessageLookupByLibrary.simpleMessage(
      "Vamos registrar um serviço que você já fez.",
    ),
    "setupFirstServiceWhen": MessageLookupByLibrary.simpleMessage(
      "Quando foi?",
    ),
    "setupPriceSheetKeep": MessageLookupByLibrary.simpleMessage(
      "Quanto fica com você",
    ),
    "setupPriceSheetName": MessageLookupByLibrary.simpleMessage(
      "Nome do serviço",
    ),
    "setupPriceSheetValue": MessageLookupByLibrary.simpleMessage(
      "Quanto você cobra",
    ),
    "setupProfessionField": MessageLookupByLibrary.simpleMessage("Profissão"),
    "setupProfessionNoMatch": MessageLookupByLibrary.simpleMessage(
      "Não achou? É só continuar escrevendo.",
    ),
    "setupProfessionSubtitle": MessageLookupByLibrary.simpleMessage(
      "Assim o Kazi já entra com seus serviços na medida certa.",
    ),
    "setupProfessionTitle": MessageLookupByLibrary.simpleMessage(
      "Antes de começar, me conta o que você faz.",
    ),
    "setupProfessionTypedSubtitle": MessageLookupByLibrary.simpleMessage(
      "Escreva do seu jeito. Se eu conhecer, já trago uma lista pronta.",
    ),
    "setupProfessionTypedTitle": MessageLookupByLibrary.simpleMessage(
      "O que você faz?",
    ),
    "setupResultBreakdown": m67,
    "setupResultCta": MessageLookupByLibrary.simpleMessage("Ver meu Kazi"),
    "setupResultLabel": MessageLookupByLibrary.simpleMessage(
      "Serviço registrado",
    ),
    "setupResultReadySubtitle": MessageLookupByLibrary.simpleMessage(
      "Assim que terminar um atendimento, toque no K no centro da barra.",
    ),
    "setupResultReadyTitle": MessageLookupByLibrary.simpleMessage(
      "Seu Kazi está pronto.",
    ),
    "setupResultYours": MessageLookupByLibrary.simpleMessage("são seus"),
    "setupSelfEmployed": MessageLookupByLibrary.simpleMessage(
      "Trabalho por conta própria",
    ),
    "setupSelfEmployedDetail": MessageLookupByLibrary.simpleMessage(
      "fico com 100%",
    ),
    "setupUnknownProfessionSubtitle": MessageLookupByLibrary.simpleMessage(
      "Sem problema — em um minuto o Kazi aprende com você. Primeiro: como você recebe?",
    ),
    "setupUnknownProfessionTitle": MessageLookupByLibrary.simpleMessage(
      "Ainda não conheço esse trabalho.",
    ),
    "share": MessageLookupByLibrary.simpleMessage("Compartilhar"),
    "showAllTypes": m68,
    "signIn": MessageLookupByLibrary.simpleMessage("Entrar"),
    "signOut": MessageLookupByLibrary.simpleMessage("Sair da conta"),
    "signOutConfirm": MessageLookupByLibrary.simpleMessage("Sair"),
    "signOutConfirmation": MessageLookupByLibrary.simpleMessage(
      "Seus serviços continuam salvos. Para vê-los de novo é só entrar com a mesma conta.",
    ),
    "signOutTitle": MessageLookupByLibrary.simpleMessage("Sair da conta?"),
    "signUp": MessageLookupByLibrary.simpleMessage("Cadastrar"),
    "signUpSuccess": MessageLookupByLibrary.simpleMessage(
      "Cadastro efetuado com sucesso",
    ),
    "situation": MessageLookupByLibrary.simpleMessage("Situação"),
    "skip": MessageLookupByLibrary.simpleMessage("Pular"),
    "splashSignature": MessageLookupByLibrary.simpleMessage("kazi · trabalho"),
    "statusPending": MessageLookupByLibrary.simpleMessage("Pendente"),
    "summary": MessageLookupByLibrary.simpleMessage("Resumo"),
    "telegram": MessageLookupByLibrary.simpleMessage("Telegram"),
    "theme": MessageLookupByLibrary.simpleMessage("Tema"),
    "themeChangeNote": MessageLookupByLibrary.simpleMessage(
      "A troca é imediata e vale para o app inteiro. O sheet continua aberto para você comparar.",
    ),
    "themeDark": MessageLookupByLibrary.simpleMessage("Escuro"),
    "themeLight": MessageLookupByLibrary.simpleMessage("Claro"),
    "themeSystem": MessageLookupByLibrary.simpleMessage("Sistema"),
    "themeSystemDetail": MessageLookupByLibrary.simpleMessage(
      "segue o aparelho",
    ),
    "thisCatalogItem": MessageLookupByLibrary.simpleMessage("esse serviço"),
    "thisClient": MessageLookupByLibrary.simpleMessage("esse cliente"),
    "thisService": MessageLookupByLibrary.simpleMessage("esse serviço"),
    "today": MessageLookupByLibrary.simpleMessage("Hoje"),
    "todaySection": m69,
    "todaysServices": MessageLookupByLibrary.simpleMessage("Serviços de hoje"),
    "topClients": MessageLookupByLibrary.simpleMessage(
      "Clientes que mais renderam",
    ),
    "total": MessageLookupByLibrary.simpleMessage("Valor total"),
    "tourAppBarDescription": MessageLookupByLibrary.simpleMessage(
      "Aqui você monta seu catálogo de serviços e sai da sua conta.",
    ),
    "tourAppBarTitle": MessageLookupByLibrary.simpleMessage("Área do Perfil"),
    "tourBottomNavigationServicesDescription": MessageLookupByLibrary.simpleMessage(
      "Nesse menu você encontrará todos os serviços que realizou além de poder cadastrar um novo serviço.",
    ),
    "tourBottomNavigationServicesTitle": MessageLookupByLibrary.simpleMessage(
      "Área de Serviços",
    ),
    "tourCatalogItemsDescription": MessageLookupByLibrary.simpleMessage(
      "Dê um nome ao serviço, como \"Cílios - Volume Brasileiro\", e preencha o valor padrão e a comissão que você recebe por ele.",
    ),
    "tourCatalogItemsTitle": MessageLookupByLibrary.simpleMessage("Catálogo"),
    "tourHomeBalanceDescription": MessageLookupByLibrary.simpleMessage(
      "Aqui é exibido os seus ganhos diários, o total descontado e o total recebido.",
    ),
    "tourHomeBalanceTitle": MessageLookupByLibrary.simpleMessage("Balanço"),
    "tourHomeServicesDescription": MessageLookupByLibrary.simpleMessage(
      "Esses são os serviços que você realizou hoje.",
    ),
    "tourHomeServicesTitle": MessageLookupByLibrary.simpleMessage(
      "Serviços do dia",
    ),
    "tourProfileDescription": MessageLookupByLibrary.simpleMessage(
      "Aqui você monta seu catálogo: os serviços que você oferece, com valor e comissão prontos para cada registro.",
    ),
    "tourProfileTitle": MessageLookupByLibrary.simpleMessage("Ações"),
    "tourServiceDetailsDescription": MessageLookupByLibrary.simpleMessage(
      "Clicando no serviço, você pode visualizar todas as informações dele, editar ou deletar.",
    ),
    "tourServiceDetailsTitle": MessageLookupByLibrary.simpleMessage(
      "Detalhes do Serviço",
    ),
    "tourServicesForm1Description": MessageLookupByLibrary.simpleMessage(
      "Escolha um serviço do seu catálogo e os valores vêm preenchidos. Dá para ajustá-los só neste registro.",
    ),
    "tourServicesForm1Title": MessageLookupByLibrary.simpleMessage(
      "Cadastrar Serviço",
    ),
    "tourServicesForm2Description": MessageLookupByLibrary.simpleMessage(
      "Basta selecionar a data do serviço realizado, a quantidade de serviços realizados, e preencher com uma descrição ou anotação caso desejar.",
    ),
    "tourServicesForm2Title": MessageLookupByLibrary.simpleMessage(
      "Cadastrar Serviço",
    ),
    "tourServicesInfoDescription": MessageLookupByLibrary.simpleMessage(
      "Aqui você pode filtrar e ordernar os serviços, bem como visualizar o saldo do período selecionado. Você também pode cadastrar os serviços realizados.",
    ),
    "tourServicesInfoTitle": MessageLookupByLibrary.simpleMessage("Serviços"),
    "tourServicesListDescription": MessageLookupByLibrary.simpleMessage(
      "Esses são todos os serviços que realizou em um determinado período de tempo. Por padrão você verá todos os serviços desse mês.",
    ),
    "tourServicesListTitle": MessageLookupByLibrary.simpleMessage("Serviços"),
    "tryAgain": MessageLookupByLibrary.simpleMessage("Tentar de novo"),
    "understood": MessageLookupByLibrary.simpleMessage("Entendi"),
    "undo": MessageLookupByLibrary.simpleMessage("Desfazer"),
    "unmarkAsReceived": MessageLookupByLibrary.simpleMessage(
      "Marcar como não recebido",
    ),
    "updateLater": MessageLookupByLibrary.simpleMessage("Depois"),
    "updateNow": MessageLookupByLibrary.simpleMessage("Atualizar"),
    "updatePassword": MessageLookupByLibrary.simpleMessage("Altualizar Senha"),
    "useExistingClient": m70,
    "usedIn": MessageLookupByLibrary.simpleMessage("Usado em"),
    "usedInServices": m71,
    "userTermsAlert1": MessageLookupByLibrary.simpleMessage(
      "Ao continuar, você concorda com os ",
    ),
    "userTermsAlert2": MessageLookupByLibrary.simpleMessage(
      "Termos de Serviço ",
    ),
    "userTermsAlert3": MessageLookupByLibrary.simpleMessage(
      "e confirma que leu a nossa ",
    ),
    "userTermsAlert4": MessageLookupByLibrary.simpleMessage(
      "Política de Privacidade",
    ),
    "usesCount": m72,
    "validatorConfirmPassword": MessageLookupByLibrary.simpleMessage(
      "As senhas não conferem",
    ),
    "validatorEmail": MessageLookupByLibrary.simpleMessage("Email inválido"),
    "validatorPassword": MessageLookupByLibrary.simpleMessage(
      "Sua senha deve ter no mínimo 8 caracteres e no máximo 16",
    ),
    "viewArchived": m73,
    "week": MessageLookupByLibrary.simpleMessage("7 dias"),
    "whatWasDone": MessageLookupByLibrary.simpleMessage("O que foi feito"),
    "whatsNewSubtitle": MessageLookupByLibrary.simpleMessage(
      "Três coisas, escritas por nós e não descobertas no meio de um atendimento.",
    ),
    "whatsNewTitle": MessageLookupByLibrary.simpleMessage("O que mudou"),
    "whatsNewVersion": m74,
    "whatsapp": MessageLookupByLibrary.simpleMessage("WhatsApp"),
    "whoWasServed": MessageLookupByLibrary.simpleMessage("Quem você atendeu"),
    "withoutCatalogItem": MessageLookupByLibrary.simpleMessage(
      "Fora do catálogo",
    ),
    "withoutCommission": MessageLookupByLibrary.simpleMessage("sem comissão"),
    "wouldYouLikeDelete": m75,
    "yesterday": MessageLookupByLibrary.simpleMessage("Ontem"),
    "youKeep": MessageLookupByLibrary.simpleMessage("Fica com você"),
    "yourEarnings": MessageLookupByLibrary.simpleMessage("Seu ganho"),
    "yourEarningsAmount": m76,
    "yoursFromThis": m77,
  };
}
