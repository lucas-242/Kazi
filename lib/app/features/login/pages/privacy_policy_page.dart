import 'package:flutter/material.dart';
import 'package:kazi/app/core/widgets/buttons/buttons.dart';
import 'package:kazi/app/core/widgets/layout/layout.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomSafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackAndPill(),
                  Text('Privacy Policy'),
                ],
              ),
              Text('''                   
                  Para ler em português, role a página.
                  
                  Lucas Guimarães built the Kazi app as an Ad Supported app. This SERVICE is provided by Lucas Guimarães at no cost and is intended for use as is.
                  
                  This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.
                  
                  If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.
                  
                  The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Kazi unless otherwise defined in this Privacy Policy.
                  
                  Information Collection and Use
                  
                  For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information, including but not limited to Name, Email Address. The information that I request will be retained on your device and is not collected by me in any way.
                  
                  The app does use third-party services that may collect information used to identify you.
                  
                  Link to the privacy policy of third-party service providers used by the app
                  
                  Google Play Services
                  AdMob
                  Google Analytics for Firebase
                  Firebase Crashlytics
                  Log Data
                  
                  I want to inform you that whenever you use my Service, in a case of an error in the app I collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing my Service, the time and date of your use of the Service, and other statistics.
                  
                  Cookies
                  
                  Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory.
                  
                  This Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.
                  
                  Service Providers
                  
                  I may employ third-party companies and individuals due to the following reasons:
                  
                  To facilitate our Service;
                  To provide the Service on our behalf;
                  To perform Service-related services; or
                  To assist us in analyzing how our Service is used.
                  I want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.
                  
                  Security
                  
                  I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.
                  
                  Links to Other Sites
                  
                  This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.
                  
                  Children’s Privacy
                  
                  These Services do not address anyone under the age of 13. I do not knowingly collect personally identifiable information from children under 13 years of age. In the case I discover that a child under 13 has provided me with personal information, I immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact me so that I will be able to do the necessary actions.
                  
                  Changes to This Privacy Policy
                  
                  I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page.
                  
                  This policy is effective as of 2023-05-26
                  
                  Contact Us
                  
                  If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at guimaraeslucas242@gmail.com.
                  
                  This privacy policy page was created at privacypolicytemplate.net and modified/generated by App Privacy Policy Generator
                  
                  
                  
                  
                  
                  Política de Privacidade em português
                  
                  
                  
                  Lucas Guimarães criou o aplicativo Kazi como um aplicativo suportado por anúncios. Este SERVIÇO é fornecido pela Lucas Guimarães sem custos e destina-se a ser utilizado tal como está.
                  
                  
                  
                  Esta página é usada para informar os visitantes sobre minhas políticas de coleta, uso e divulgação de informações pessoais, caso alguém decida usar meu serviço.
                  
                  
                  
                  Se você optar por usar meu serviço, concorda com a coleta e o uso de informações relacionadas a esta política. As Informações Pessoais que eu coleto são usadas para fornecer e melhorar o Serviço. Não usarei ou compartilharei suas informações com ninguém, exceto conforme descrito nesta Política de Privacidade.
                  
                  
                  
                  Os termos usados nesta Política de Privacidade têm os mesmos significados que em nossos Termos e Condições, que podem ser acessados no Kazi, a menos que definido de outra forma nesta Política de Privacidade.
                  
                  
                  
                  Coleta e uso de informações
                  
                  
                  
                  Para uma melhor experiência, ao usar nosso Serviço, posso exigir que você nos forneça certas informações de identificação pessoal, incluindo, entre outras, Nome, Endereço de e-mail. As informações que solicito serão mantidas em seu dispositivo e não serão coletadas por mim de forma alguma.
                  
                  
                  
                  O aplicativo usa serviços de terceiros que podem coletar informações usadas para identificá-lo.
                  
                  
                  
                  Link para a política de privacidade de provedores de serviços terceirizados usados pelo app
                  
                  
                  
                  Serviços do Google Play
                  
                  AdMob
                  
                  Google Analytics para Firebase
                  
                  Firebase Crashlytics
                  
                  Dados de registro
                  
                  
                  
                  Quero informar que sempre que você usa meu Serviço, em caso de erro no aplicativo, eu coleto dados e informações (através de produtos de terceiros) em seu telefone chamado Log Data. Esses dados de registro podem incluir informações como endereço de protocolo de Internet ("IP") do dispositivo, nome do dispositivo, versão do sistema operacional, configuração do aplicativo ao utilizar meu serviço, hora e data de uso do serviço e outras estatísticas .
                  
                  
                  
                  Cookies
                  
                  
                  
                  Cookies são arquivos com uma pequena quantidade de dados que são comumente usados como identificadores únicos anônimos. Estes são enviados para o seu navegador a partir dos sites que você visita e são armazenados na memória interna do seu dispositivo.
                  
                  
                  
                  Este Serviço não usa esses “cookies” explicitamente. No entanto, o aplicativo pode usar código e bibliotecas de terceiros que usam “cookies” para coletar informações e melhorar seus serviços. Você tem a opção de aceitar ou recusar esses cookies e saber quando um cookie está sendo enviado ao seu dispositivo. Se você optar por recusar nossos cookies, talvez não consiga usar algumas partes deste Serviço.
                  
                  
                  
                  Provedores de serviço
                  
                  
                  
                  Posso contratar empresas e indivíduos terceirizados pelos seguintes motivos:
                  
                  
                  
                  Para facilitar nosso Serviço;
                  
                  Para fornecer o Serviço em nosso nome;
                  
                  Para realizar serviços relacionados ao Serviço; ou
                  
                  Para nos ajudar a analisar como nosso Serviço é usado.
                  
                  Desejo informar aos usuários deste Serviço que esses terceiros têm acesso às suas Informações Pessoais. O motivo é realizar as tarefas atribuídas a eles em nosso nome. No entanto, eles são obrigados a não divulgar ou usar as informações para qualquer outra finalidade.
                  
                  
                  
                  Segurança
                  
                  
                  
                  Eu valorizo sua confiança em nos fornecer suas informações pessoais, portanto, estamos nos esforçando para usar meios comercialmente aceitáveis de protegê-las. Mas lembre-se que nenhum método de transmissão pela internet, ou método de armazenamento eletrônico é 100% seguro e confiável, e não posso garantir sua segurança absoluta.
                  
                  
                  
                  Links para outros sites
                  
                  
                  
                  Este Serviço pode conter links para outros sites. Se você clicar em um link de terceiros, será direcionado para esse site. Observe que esses sites externos não são operados por mim. Portanto, aconselho fortemente que você revise a Política de Privacidade desses sites. Não tenho controle e não assumo nenhuma responsabilidade pelo conteúdo, políticas de privacidade ou práticas de sites ou serviços de terceiros.
                  
                  
                  
                  Privacidade das crianças
                  
                  
                  
                  Esses Serviços não se dirigem a menores de 13 anos. Não coleto intencionalmente informações de identificação pessoal de crianças menores de 13 anos. No caso de eu descobrir que uma criança menor de 13 anos me forneceu informações pessoais, eu as excluo imediatamente de nossos servidores. Se você é pai ou responsável e está ciente de que seu filho nos forneceu informações pessoais, entre em contato comigo para que eu possa tomar as medidas necessárias.
                  
                  
                  
                  Mudanças nesta Política de Privacidade
                  
                  
                  
                  Posso atualizar nossa Política de Privacidade de tempos em tempos. Assim, você é aconselhado a revisar esta página periodicamente para quaisquer alterações. Vou notificá-lo sobre quaisquer alterações, publicando a nova Política de Privacidade nesta página.
                  
                  
                  
                  Esta política é efetiva a partir de 2023-05-26
                  
                  
                  
                  Contate-nos
                  
                  
                  
                  Se tiver alguma dúvida ou sugestão sobre a minha Política de Privacidade, não hesite em contactar-me em guimaraeslucas242@gmail.com.
                  
                  
                  
                  Esta página de política de privacidade foi criada em privacypolicytemplate.net e modificada/gerada pelo App Privacy Policy Generator
                '''),
            ],
          ),
        ),
      ),
    );
  }
}
