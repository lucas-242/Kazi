import 'package:flutter/material.dart';
import 'package:kazi_core/shared/components/buttons/kazi_elevated_button.dart';
import 'package:kazi_core/shared/components/status/kazi_empty.dart';
import 'package:kazi_core/shared/components/status/kazi_error.dart';
import 'package:kazi_core/shared/components/status/kazi_no_results.dart';
import 'package:kazi_core/shared/components/status/kazi_skeleton.dart';
import 'package:kazi_core/shared/themes/extensions/theme_extension.dart';
import 'package:kazi_core/shared/themes/kazi_colors.dart';
import 'package:kazi_core/shared/themes/settings/kazi_insets.dart';
import 'package:kazi_core/shared/themes/settings/kazi_radii.dart';
import 'package:kazi_core/shared/themes/settings/kazi_spacings.dart';
import 'package:kazi_core/shared/themes/settings/kazi_text_styles.dart';
import 'package:kazi_core/shared/themes/settings/kazi_theme_settings.dart';

/// Every design token, rendered in light and dark at the same time.
///
/// This is the answer to "which colour do I use here?": scroll to the thing
/// that looks like what you are building and read the token name printed on
/// it. Both columns are live — each is a real subtree under the real
/// `ThemeData`, not a mock — so whatever you see here is exactly what a screen
/// gets from `context.colors`.
///
/// Debug-only by convention: register it behind `kDebugMode`.
class KaziThemeGalleryPage extends StatelessWidget {
  const KaziThemeGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Design tokens')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Side by side when there is room; stacked otherwise, so the page
          // still works on a phone.
          final isWide = constraints.maxWidth >= 720;

          if (isWide) {
            return const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(child: _ThemePanel(label: 'light', isDark: false)),
                Expanded(child: _ThemePanel(label: 'dark', isDark: true)),
              ],
            );
          }

          return ListView(
            children: const <Widget>[
              SizedBox(
                height: 520,
                child: _ThemePanel(label: 'light', isDark: false),
              ),
              SizedBox(
                height: 520,
                child: _ThemePanel(label: 'dark', isDark: true),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// One column: a real [Theme] of the given brightness wrapped around the token
/// list, so every swatch resolves the way a screen would.
class _ThemePanel extends StatelessWidget {
  const _ThemePanel({required this.label, required this.isDark});

  final String label;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: isDark ? KaziThemeSettings.dark() : KaziThemeSettings.light(),
      child: Builder(
        builder: (context) => ColoredBox(
          color: context.colors.background,
          child: ListView(
            padding: const EdgeInsets.all(KaziInsets.md),
            children: <Widget>[
              Text(
                label.toUpperCase(),
                style: KaziTextStyles.tag.copyWith(
                  color: context.colors.textMuted,
                ),
              ),
              KaziSpacings.verticalMd,
              const _SurfacesSection(),
              const _InkSection(),
              const _BrandSection(),
              const _StatusSection(),
              const _MoneySection(),
              const _HeroSection(),
              const _CategoriesSection(),
              const _StatesSection(),
              const _TypeSection(),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Sections ───────────────────────────────────────────────────────────────

class _SurfacesSection extends StatelessWidget {
  const _SurfacesSection();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return _Section(
      title: 'Superfícies',
      child: Column(
        children: <Widget>[
          _Swatch('background', colors.background, colors.text),
          _Swatch('card', colors.card, colors.text),
          _Swatch('surfaceMuted', colors.surfaceMuted, colors.text),
          _Swatch('surfaceStrong', colors.surfaceStrong, colors.text),
          _Swatch('inverse / onInverse', colors.inverse, colors.onInverse),
          _Swatch('inverse / inverseAccent', colors.inverse, colors.inverseAccent),
          // Translucent by design, so it is shown over `card` rather than as a
          // flat chip — a scrim's whole job is what stays visible through it.
          _Swatch(
            'scrim',
            Color.alphaBlend(colors.scrim, colors.card),
            colors.onInverse,
          ),
        ],
      ),
    );
  }
}

class _InkSection extends StatelessWidget {
  const _InkSection();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return _Section(
      title: 'Tinta e bordas',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'text',
            style: KaziTextStyles.bodyMedium.copyWith(color: colors.text),
          ),
          Text(
            'textMuted',
            style: KaziTextStyles.bodyMedium.copyWith(color: colors.textMuted),
          ),
          KaziSpacings.verticalXs,
          _Rule('border', colors.border),
          _Rule('borderStrong', colors.borderStrong),
          _Rule('focusRing', colors.focusRing),
        ],
      ),
    );
  }
}

class _BrandSection extends StatelessWidget {
  const _BrandSection();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final brand = colors.brand;

    return _Section(
      title: 'Marca',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _Swatch('brand.fill / onFill', brand.fill, brand.onFill),
          _Swatch('brand.pressed', brand.pressed, brand.onFill),
          _Swatch('brand.surface / onSurface', brand.surface, brand.onSurface),
          KaziSpacings.verticalXs,
          // The pair that exists because yellow cannot be read on Névoa.
          Text(
            'brand.text — escrever em amarelo',
            style: KaziTextStyles.bodyMedium.copyWith(color: brand.text),
          ),
          Text(
            'brand.textStrong — o mesmo, em corpo pequeno',
            style: KaziTextStyles.bodySmall.copyWith(color: brand.textStrong),
          ),
        ],
      ),
    );
  }
}

class _StatusSection extends StatelessWidget {
  const _StatusSection();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return _Section(
      title: 'Status',
      child: Column(
        children: <Widget>[
          for (final entry in <String, KaziStatusColors>{
            'success': colors.success,
            'warning': colors.warning,
            'info': colors.info,
            'danger': colors.danger,
          }.entries)
            Padding(
              padding: const EdgeInsets.only(bottom: KaziInsets.xs),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: _Swatch(
                      '${entry.key}.fill',
                      entry.value.fill,
                      entry.value.onFill,
                    ),
                  ),
                  KaziSpacings.horizontalXs,
                  Expanded(
                    child: _Swatch(
                      '${entry.key}.surface + .surfaceBorder',
                      entry.value.surface,
                      entry.value.onSurface,
                      border: entry.value.surfaceBorder,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _MoneySection extends StatelessWidget {
  const _MoneySection();

  @override
  Widget build(BuildContext context) {
    final money = context.colors.money;

    return _Section(
      title: 'Dinheiro',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(KaziInsets.md),
        decoration: BoxDecoration(
          color: money.surface,
          borderRadius: KaziRadii.mdBorder,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'money.label',
              style: KaziTextStyles.tag.copyWith(color: money.label),
            ),
            Text(
              'R\$ 4.280,00',
              style: KaziTextStyles.amount.copyWith(color: money.onSurface),
            ),
            Text(
              'A receber · money.accent',
              style: KaziTextStyles.bodySmall.copyWith(color: money.accent),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final hero = context.colors.hero;

    return _Section(
      title: 'Hero (splash, login)',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(KaziInsets.md),
        decoration: BoxDecoration(
          color: hero.surface,
          borderRadius: KaziRadii.mdBorder,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(width: 18, height: 18, color: hero.mark),
                KaziSpacings.horizontalXs,
                Text(
                  'kazi',
                  style: KaziTextStyles.wordmarkAt(28).copyWith(
                    color: hero.ink,
                  ),
                ),
              ],
            ),
            Text(
              'hero.muted · assinatura',
              style: KaziTextStyles.tag.copyWith(color: hero.muted),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoriesSection extends StatelessWidget {
  const _CategoriesSection();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return _Section(
      title: 'Categorias',
      child: Wrap(
        spacing: KaziInsets.xs,
        runSpacing: KaziInsets.xs,
        children: <Widget>[
          for (var index = 0; index < colors.categories.length; index++)
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: colors.category(index),
                shape: BoxShape.circle,
                // The ring the docs ask for: several of them fall under 3:1 on
                // a light surface.
                border: Border.all(color: colors.border),
              ),
            ),
        ],
      ),
    );
  }
}

/// The four screen states side by side, which is the only place their
/// differences are obvious: the brand block belongs to the empty account and
/// to nothing else.
class _StatesSection extends StatelessWidget {
  const _StatesSection();

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'Estados de tela',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: KaziInsets.lg,
        children: <Widget>[
          const KaziSkeletonList(count: 2),
          const _Caption('Carregando · inerte, o resto da tela continua vivo'),
          KaziEmpty(
            message: 'Seus clientes aparecem aqui',
            description:
                'Eles são criados sozinhos conforme você registra serviços.',
            action: KaziElevatedButton.label(
              onTap: () {},
              label: 'Cadastrar cliente',
            ),
          ),
          const _Caption('Vazio · conta sem dados naquela coleção'),
          KaziNoResults(
            icon: Icons.search,
            message: 'Nada encontrado para “gel de fibra”',
            description:
                'Nenhum serviço, cliente ou item do catálogo com esse nome.',
            actionLabel: 'Criar “gel de fibra” no catálogo',
            onAction: () {},
          ),
          const _Caption('Sem resultados · nunca o bloco amarelo'),
          KaziError(
            message: 'Não conseguimos carregar seus serviços',
            onRetry: () {},
            code: 'ERR-503 · 14:22',
          ),
          const _Caption('Erro · o que houve, que os dados estão a salvo'),
        ],
      ),
    );
  }
}

class _TypeSection extends StatelessWidget {
  const _TypeSection();

  @override
  Widget build(BuildContext context) {
    const scale = <String, TextStyle>{
      'displayLarge': KaziTextStyles.displayLarge,
      'displayMedium': KaziTextStyles.displayMedium,
      'displaySmall': KaziTextStyles.displaySmall,
      'headlineLarge': KaziTextStyles.headlineLarge,
      'headlineMedium': KaziTextStyles.headlineMedium,
      'headlineSmall': KaziTextStyles.headlineSmall,
      'titleLarge': KaziTextStyles.titleLarge,
      'titleMedium': KaziTextStyles.titleMedium,
      'titleSmall': KaziTextStyles.titleSmall,
      'bodyLarge': KaziTextStyles.bodyLarge,
      'bodyMedium': KaziTextStyles.bodyMedium,
      'bodySmall': KaziTextStyles.bodySmall,
      'labelLarge': KaziTextStyles.labelLarge,
      'labelMedium': KaziTextStyles.labelMedium,
      'labelSmall': KaziTextStyles.labelSmall,
      'tag': KaziTextStyles.tag,
      'amount': KaziTextStyles.amount,
    };

    final colors = context.colors;

    return _Section(
      title: 'Tipografia',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (final entry in scale.entries) ...<Widget>[
            Text(
              entry.key,
              style: KaziTextStyles.tag.copyWith(color: colors.textMuted),
            ),
            Text(
              entry.key == 'amount' ? 'R\$ 4.280,00' : 'Kazi',
              style: entry.value.copyWith(color: colors.text),
            ),
            KaziSpacings.verticalXs,
          ],
        ],
      ),
    );
  }
}

// ── Building blocks ────────────────────────────────────────────────────────

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.only(bottom: KaziInsets.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: KaziTextStyles.titleSmall.copyWith(color: colors.text),
          ),
          Divider(color: colors.border),
          KaziSpacings.verticalXs,
          child,
        ],
      ),
    );
  }
}

/// A colour block labelled with the token that produced it.
class _Swatch extends StatelessWidget {
  const _Swatch(this.token, this.color, this.onColor, {this.border});

  final String token;
  final Color color;
  final Color onColor;

  /// Drawn instead of the neutral outline, for a wash that ships with an edge
  /// of its own.
  final Color? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: KaziInsets.xxs),
      padding: const EdgeInsets.all(KaziInsets.sm),
      decoration: BoxDecoration(
        color: color,
        borderRadius: KaziRadii.xsBorder,
        border: Border.all(color: border ?? context.colors.border),
      ),
      child: Text(
        token,
        style: KaziTextStyles.tag.copyWith(color: onColor),
      ),
    );
  }
}

/// The line under a rendered component, naming what it is for.
class _Caption extends StatelessWidget {
  const _Caption(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: KaziTextStyles.tag.copyWith(color: context.colors.textMuted),
      textAlign: TextAlign.center,
    );
  }
}

/// A 2px rule, for tokens that only ever show up as a line.
class _Rule extends StatelessWidget {
  const _Rule(this.token, this.color);

  final String token;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: KaziInsets.xs),
      child: Row(
        children: <Widget>[
          Container(width: 48, height: 2, color: color),
          KaziSpacings.horizontalXs,
          Text(
            token,
            style: KaziTextStyles.tag.copyWith(
              color: context.colors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
