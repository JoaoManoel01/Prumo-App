import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

enum _CatalogKind { labor, part }

class _CatalogItem {
  const _CatalogItem({
    required this.name,
    required this.detail,
    required this.unit,
    required this.priceCents,
    required this.kind,
  });

  final String name;
  final String detail;
  final String unit;
  final int priceCents;
  final _CatalogKind kind;
}

class _CatalogSection {
  const _CatalogSection({required this.title, required this.items});

  final String title;
  final List<_CatalogItem> items;
}

const List<_CatalogSection> _sections = [
  _CatalogSection(
    title: 'INSTALAÇÃO & MONTAGEM',
    items: [
      _CatalogItem(
        name: 'Instalação Split Inverter',
        detail: '~2h30',
        unit: 'UN',
        priceCents: 45000,
        kind: _CatalogKind.labor,
      ),
      _CatalogItem(
        name: 'Instalação Split 18.000 BTUs',
        detail: '~3h30',
        unit: 'UN',
        priceCents: 65000,
        kind: _CatalogKind.labor,
      ),
      _CatalogItem(
        name: 'Ponto elétrico dedicado',
        detail: 'Padrão NBR',
        unit: 'PT',
        priceCents: 18000,
        kind: _CatalogKind.labor,
      ),
      _CatalogItem(
        name: 'Passagem tubulação e furação',
        detail: 'Metro linear adic.',
        unit: 'M',
        priceCents: 10000,
        kind: _CatalogKind.labor,
      ),
    ],
  ),
  _CatalogSection(
    title: 'MANUTENÇÃO & HIGIENIZAÇÃO',
    items: [
      _CatalogItem(
        name: 'Higienização completa',
        detail: 'Vapor + químico',
        unit: 'UN',
        priceCents: 22000,
        kind: _CatalogKind.labor,
      ),
      _CatalogItem(
        name: 'Carga de fluido refrigerante',
        detail: 'Incluso vácuo',
        unit: 'KG',
        priceCents: 16000,
        kind: _CatalogKind.labor,
      ),
      _CatalogItem(
        name: 'Troca de capacitor',
        detail: 'Mão de obra téc.',
        unit: 'UN',
        priceCents: 15000,
        kind: _CatalogKind.labor,
      ),
    ],
  ),
  _CatalogSection(
    title: 'DIAGNÓSTICO & VISITA',
    items: [
      _CatalogItem(
        name: 'Visita técnica e teste',
        detail: 'Pressurização N2',
        unit: 'VISITA',
        priceCents: 12000,
        kind: _CatalogKind.labor,
      ),
      _CatalogItem(
        name: 'Laudo técnico',
        detail: 'Com fotos e ART',
        unit: 'UN',
        priceCents: 20000,
        kind: _CatalogKind.labor,
      ),
    ],
  ),
  _CatalogSection(
    title: 'PEÇAS & MATERIAIS',
    items: [
      _CatalogItem(
        name: 'Suporte condensadora 450mm',
        detail: 'Aço galvanizado',
        unit: 'PAR',
        priceCents: 11000,
        kind: _CatalogKind.part,
      ),
      _CatalogItem(
        name: 'Tubo de cobre 1/4 e 3/8',
        detail: 'Classe A com isolamento',
        unit: 'M',
        priceCents: 24800,
        kind: _CatalogKind.part,
      ),
      _CatalogItem(
        name: 'Fita branca de acabamento',
        detail: 'Rolo de 10m',
        unit: 'RL',
        priceCents: 1500,
        kind: _CatalogKind.part,
      ),
    ],
  ),
];

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  _CatalogKind _kind = _CatalogKind.labor;
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final filteredSections = _sections
        .map(
          (section) => _CatalogSection(
            title: section.title,
            items: section.items
                .where(
                  (item) =>
                      item.kind == _kind &&
                      (_query.isEmpty ||
                          item.name.toLowerCase().contains(
                            _query.toLowerCase(),
                          )),
                )
                .toList(),
          ),
        )
        .where((section) => section.items.isNotEmpty)
        .toList();

    final allItems = _sections.expand((section) => section.items).toList();
    final laborCount = allItems
        .where((item) => item.kind == _CatalogKind.labor)
        .length;
    final partCount = allItems
        .where((item) => item.kind == _CatalogKind.part)
        .length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Preços'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.person, color: AppColors.onPrimary),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            onChanged: (value) => setState(() => _query = value),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Buscar serviço ou código...',
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _KindPill(
                label: 'Mão de obra ($laborCount)',
                selected: _kind == _CatalogKind.labor,
                onTap: () => setState(() => _kind = _CatalogKind.labor),
              ),
              const SizedBox(width: 8),
              _KindPill(
                label: 'Peças ($partCount)',
                selected: _kind == _CatalogKind.part,
                onTap: () => setState(() => _kind = _CatalogKind.part),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (filteredSections.isEmpty)
            const _CatalogEmptyState()
          else
            for (final section in filteredSections) ...[
              Text(
                '${section.title} (${section.items.length})',
                style: Theme.of(context).textTheme.labelSmall
                    ?.copyWith(color: AppColors.onSurfaceVariant),
              ),
              const SizedBox(height: 8),
              for (var i = 0; i < section.items.length; i++) ...[
                _CatalogItemCard(item: section.items[i]),
                if (i != section.items.length - 1) const SizedBox(height: 8),
              ],
              const SizedBox(height: 20),
            ],
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        icon: const Icon(Icons.add),
        label: const Text('Novo item'),
      ),
    );
  }
}

class _KindPill extends StatelessWidget {
  const _KindPill({
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

class _CatalogItemCard extends StatelessWidget {
  const _CatalogItemCard({required this.item});

  final _CatalogItem item;

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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(item.unit, style: textTheme.labelSmall),
            ),
            const SizedBox(width: 12),
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
          ],
        ),
      ),
    );
  }
}

class _CatalogEmptyState extends StatelessWidget {
  const _CatalogEmptyState();

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
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.inventory_2_outlined, size: 32),
            ),
            const SizedBox(height: 16),
            Text('Seu catálogo está vazio', style: textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              'Cadastre seus preços e serviços para montar orçamentos em segundos direto no cliente.',
              textAlign: TextAlign.center,
              style: textTheme.bodySmall?.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Cadastrar primeiro item'),
            ),
          ],
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
