import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class _PickerItem {
  const _PickerItem({
    required this.name,
    required this.detail,
    required this.priceCents,
    required this.kind,
  });

  final String name;
  final String detail;
  final int priceCents;
  final int kind;
}

const List<_PickerItem> _items = [
  _PickerItem(
    name: 'Higienização e Limpeza Split até 18.000 BTUs',
    detail: 'Tabela padrão: R\$ 300,00 • Estimado 1h30',
    priceCents: 30000,
    kind: 0,
  ),
  _PickerItem(
    name: 'Carga de gás refrigerante R410A',
    detail: 'Até 18.000 BTUs • Garrafa inclusa',
    priceCents: 22000,
    kind: 0,
  ),
  _PickerItem(
    name: 'Substituição de capacitor duplo',
    detail: 'Motor ventilador + compressor',
    priceCents: 18000,
    kind: 0,
  ),
  _PickerItem(
    name: 'Desinstalação de evaporadora',
    detail: 'Desmonte técnico com recolhimento',
    priceCents: 25000,
    kind: 0,
  ),
  _PickerItem(
    name: 'Suporte reforçado para condensadora 450mm',
    detail: 'Aço galvanizado com pintura eletrostática',
    priceCents: 11000,
    kind: 1,
  ),
  _PickerItem(
    name: 'Tubo de cobre 1/4 e 3/8 com isolamento',
    detail: 'Normalizado Classe A',
    priceCents: 24800,
    kind: 1,
  ),
];

class CatalogPickerScreen extends StatefulWidget {
  const CatalogPickerScreen({super.key, this.initialTab = 0});

  final int initialTab;

  @override
  State<CatalogPickerScreen> createState() => _CatalogPickerScreenState();
}

class _CatalogPickerScreenState extends State<CatalogPickerScreen> {
  late int _tab = widget.initialTab;
  _PickerItem? _selected;
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final filtered = _items.where((item) => item.kind == _tab).toList();

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.of(context).pop()),
        title: const Text('Adicionar do catálogo'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Buscar serviço ou código...',
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _TabPill(
                      label:
                          'Mão de obra (${_items.where((i) => i.kind == 0).length})',
                      selected: _tab == 0,
                      onTap: () => setState(() => _tab = 0),
                    ),
                    const SizedBox(width: 8),
                    _TabPill(
                      label:
                          'Peças e materiais (${_items.where((i) => i.kind == 1).length})',
                      selected: _tab == 1,
                      onTap: () => setState(() => _tab = 1),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (_selected != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _SelectedItemCard(
                item: _selected!,
                quantity: _quantity,
                onDecrement: _quantity > 1
                    ? () => setState(() => _quantity--)
                    : null,
                onIncrement: () => setState(() => _quantity++),
              ),
            ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                for (var i = 0; i < filtered.length; i++) ...[
                  _PickerItemCard(
                    item: filtered[i],
                    onTap: () => setState(() {
                      _selected = filtered[i];
                      _quantity = 1;
                    }),
                  ),
                  if (i != filtered.length - 1) const SizedBox(height: 8),
                ],
              ],
            ),
          ),
        ],
      ),
      bottomSheet: _selected == null
          ? null
          : SafeArea(
              child: Container(
                padding: const EdgeInsets.all(16),
                color: AppColors.surface,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '1 serviço • ${_formatCurrency(_selected!.priceCents * _quantity)}',
                        style: textTheme.titleMedium,
                      ),
                    ),
                    FilledButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Adicionar ao Orçamento'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class _TabPill extends StatelessWidget {
  const _TabPill({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = selected ? AppColors.onPrimary : AppColors.onSurface;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.outlineVariant,
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelMedium
              ?.copyWith(color: foreground),
        ),
      ),
    );
  }
}

class _SelectedItemCard extends StatelessWidget {
  const _SelectedItemCard({
    required this.item,
    required this.quantity,
    required this.onDecrement,
    required this.onIncrement,
  });

  final _PickerItem item;
  final int quantity;
  final VoidCallback? onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.accent),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.check_circle, color: AppColors.accent),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'SELECIONADO',
                    style: textTheme.labelSmall?.copyWith(
                      color: AppColors.accent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(item.name, style: textTheme.titleMedium),
            const SizedBox(height: 2),
            Text(
              item.detail,
              style: textTheme.bodySmall?.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text('QUANTIDADE', style: textTheme.labelSmall),
                const Spacer(),
                IconButton(
                  onPressed: onDecrement,
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text('$quantity', style: textTheme.titleMedium),
                IconButton(
                  onPressed: onIncrement,
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            Row(
              children: [
                Text('PREÇO COBRADO', style: textTheme.labelSmall),
                const Spacer(),
                Text(
                  _formatCurrency(item.priceCents),
                  style: textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text('Subtotal deste serviço:', style: textTheme.bodySmall),
                const Spacer(),
                Text(
                  _formatCurrency(item.priceCents * quantity),
                  style: textTheme.titleMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PickerItemCard extends StatelessWidget {
  const _PickerItemCard({required this.item, required this.onTap});

  final _PickerItem item;
  final VoidCallback onTap;

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
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name, style: textTheme.bodyMedium),
                    const SizedBox(height: 2),
                    Text(
                      item.detail,
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                _formatCurrency(item.priceCents),
                style: textTheme.titleMedium,
              ),
              const SizedBox(width: 4),
              const Icon(Icons.add_circle_outline, color: AppColors.accent),
            ],
          ),
        ),
      ),
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
