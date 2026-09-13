import 'package:flutter/material.dart';

import '../components/step_progress.dart';
import '../theme/app_colors.dart';
import 'catalog_picker_screen.dart';
import 'new_quote_preview_screen.dart';

class _LineItem {
  const _LineItem({
    required this.title,
    required this.detail,
    required this.tag,
    required this.code,
    required this.valueCents,
  });

  final String title;
  final String detail;
  final String tag;
  final String code;
  final int valueCents;
}

const List<_LineItem> _laborItems = [
  _LineItem(
    title: 'Instalação Split Inverter 12.000 BTUs',
    detail: '1 un x R\$ 450,00',
    tag: 'ELÉTRICA / AR',
    code: 'Código: SV-1204',
    valueCents: 45000,
  ),
  _LineItem(
    title: 'Instalação de tubulação e furação técnica',
    detail: '2 m x R\$ 100,00',
    tag: 'ALVENARIA',
    code: 'Código: SV-0982',
    valueCents: 20000,
  ),
];

const List<_LineItem> _materialItems = [
  _LineItem(
    title: 'Suporte reforçado para condensadora 450mm',
    detail: '1 par x R\$ 110,00',
    tag: 'FIXAÇÃO',
    code: 'Ref: SP-INOX-45',
    valueCents: 11000,
  ),
  _LineItem(
    title: 'Tubo de cobre 1/4 e 3/8 com isolamento térmico blindado',
    detail: '3 m x R\$ 240,00/m',
    tag: 'COBRE',
    code: 'Ref: TB-CP-ISO',
    valueCents: 72000,
  ),
];

class NewQuoteItemsScreen extends StatelessWidget {
  const NewQuoteItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final laborTotal = _laborItems.fold<int>(
      0,
      (sum, item) => sum + item.valueCents,
    );
    final materialTotal = _materialItems.fold<int>(
      0,
      (sum, item) => sum + item.valueCents,
    );
    final total = laborTotal + materialTotal;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.of(context).pop()),
        title: const Text('Montagem dos Itens'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Text(
                'ETAPA 2 DE 3',
                style: textTheme.labelSmall?.copyWith(color: AppColors.accent),
              ),
              const Spacer(),
              Text('2 / 3', style: textTheme.labelSmall),
            ],
          ),
          const SizedBox(height: 8),
          const StepProgress(currentStep: 2, totalSteps: 3),
          const SizedBox(height: 16),
          _ClientHeader(),
          const SizedBox(height: 20),
          _ItemsSection(
            title: 'MÃO DE OBRA',
            subtitle: 'SUBTOTAL ${_formatCurrency(laborTotal)}',
            items: _laborItems,
            addLabel: 'Adicionar serviço de mão de obra',
            addTab: 0,
          ),
          const SizedBox(height: 20),
          _ItemsSection(
            title: 'PEÇAS E MATERIAIS',
            subtitle: 'SUBTOTAL ${_formatCurrency(materialTotal)}',
            items: _materialItems,
            addLabel: 'Adicionar material ou peça',
            addTab: 1,
          ),
          const SizedBox(height: 20),
          const _WarrantyNote(),
          const SizedBox(height: 20),
          _Summary(total: total),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const NewQuotePreviewScreen()),
            ),
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Revisar e Gerar Orçamento'),
          ),
        ],
      ),
    );
  }
}

class _ClientHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CLIENTE',
                style: textTheme.labelSmall?.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 2),
              Text('Roberto Silveira', style: textTheme.titleMedium),
              Text(
                'Jardim das Flores, SP',
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        TextButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.swap_horiz),
          label: const Text('TROCAR'),
        ),
      ],
    );
  }
}

class _ItemsSection extends StatelessWidget {
  const _ItemsSection({
    required this.title,
    required this.subtitle,
    required this.items,
    required this.addLabel,
    required this.addTab,
  });

  final String title;
  final String subtitle;
  final List<_LineItem> items;
  final String addLabel;
  final int addTab;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: textTheme.labelSmall?.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
            const Spacer(),
            Text(subtitle, style: textTheme.labelSmall),
          ],
        ),
        const SizedBox(height: 8),
        for (var i = 0; i < items.length; i++) ...[
          _LineItemCard(item: items[i]),
          if (i != items.length - 1) const SizedBox(height: 8),
        ],
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => CatalogPickerScreen(initialTab: addTab),
            ),
          ),
          icon: const Icon(Icons.add),
          label: Text(addLabel),
        ),
      ],
    );
  }
}

class _LineItemCard extends StatelessWidget {
  const _LineItemCard({required this.item});

  final _LineItem item;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: textTheme.bodyMedium),
                  const SizedBox(height: 4),
                  Text(
                    item.detail,
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(item.tag, style: textTheme.labelSmall),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        item.code,
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined)),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ),
      ),
    );
  }
}

class _WarrantyNote extends StatelessWidget {
  const _WarrantyNote();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.verified_user, color: AppColors.accent),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Garantia padrão de 90 dias aplicada',
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: 2),
                Text(
                  'Os itens cadastrados compõem o termo de serviço e recibo na finalização da Etapa 3.',
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.onSurfaceVariant,
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

class _Summary extends StatelessWidget {
  const _Summary({required this.total});

  final int total;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SummaryRow(
          label: 'Subtotal dos itens (4 itens)',
          value: _formatCurrency(total),
        ),
        const SizedBox(height: 8),
        const _SummaryRow(label: 'Aplicar desconto', value: '- R\$ 0,00'),
        const SizedBox(height: 12),
        Row(
          children: [
            Text('VALOR TOTAL', style: textTheme.labelLarge),
            const Spacer(),
            Text(_formatCurrency(total), style: textTheme.headlineMedium),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Em até 3x sem juros',
          style: textTheme.bodySmall?.copyWith(color: AppColors.accent),
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
        const Spacer(),
        Text(value, style: textTheme.bodyMedium),
      ],
    );
  }
}

String _formatCurrency(int cents) {
  final reais = cents ~/ 100;
  final centavos = cents % 100;
  return 'R\$ ${_thousands(reais)},${centavos.toString().padLeft(2, '0')}';
}

String _thousands(int value) {
  final digits = value.toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) {
      buffer.write('.');
    }
    buffer.write(digits[i]);
  }
  return buffer.toString();
}
