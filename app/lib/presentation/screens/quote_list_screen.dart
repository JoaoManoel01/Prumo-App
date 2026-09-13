import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

enum _QuoteStatus { draft, sent, approved, refused }

extension _QuoteStatusX on _QuoteStatus {
  String get label => switch (this) {
    _QuoteStatus.draft => 'RASCUNHO',
    _QuoteStatus.sent => 'ENVIADO',
    _QuoteStatus.approved => 'APROVADO',
    _QuoteStatus.refused => 'RECUSADO',
  };

  Color get color => switch (this) {
    _QuoteStatus.draft => AppColors.onSurfaceVariant,
    _QuoteStatus.sent => AppColors.warning,
    _QuoteStatus.approved => AppColors.accent,
    _QuoteStatus.refused => AppColors.error,
  };
}

enum _Filter { all, draft, sent }

extension _FilterX on _Filter {
  String get label => switch (this) {
    _Filter.all => 'Todos',
    _Filter.draft => 'Rascunho',
    _Filter.sent => 'Enviados',
  };

  bool matches(_Quote quote) => switch (this) {
    _Filter.all => true,
    _Filter.draft => quote.status == _QuoteStatus.draft,
    _Filter.sent => quote.status == _QuoteStatus.sent,
  };
}

class _Quote {
  const _Quote({
    required this.clientName,
    required this.address,
    required this.service,
    required this.dateLabel,
    required this.valueCents,
    required this.status,
  });

  final String clientName;
  final String address;
  final String service;
  final String dateLabel;
  final int valueCents;
  final _QuoteStatus status;
}

const List<_Quote> _quotes = [
  _Quote(
    clientName: 'Roberto Silveira',
    address: 'Edifício Solaris, Apt 82',
    service: 'Instalação Split Inverter 12.000 BTUs',
    dateLabel: 'Hoje, 14:20',
    valueCents: 148000,
    status: _QuoteStatus.approved,
  ),
  _Quote(
    clientName: 'Ana Paula Mendes',
    address: 'Rua Barão de Limeira, 1024',
    service: 'Higienização de 3 aparelhos',
    dateLabel: 'Hoje, 10:05',
    valueCents: 66000,
    status: _QuoteStatus.sent,
  ),
  _Quote(
    clientName: 'Condomínio Lar das Flores',
    address: 'Portaria Central, Vila Mariana',
    service: 'Manutenção preventiva — 6 evaporadoras',
    dateLabel: 'Ontem, 17:40',
    valueCents: 234000,
    status: _QuoteStatus.draft,
  ),
  _Quote(
    clientName: 'Marcos Andrade',
    address: 'Rua Augusta, 1420, Consolação',
    service: 'Instalação de ponto elétrico dedicado',
    dateLabel: 'Ontem, 09:15',
    valueCents: 18000,
    status: _QuoteStatus.sent,
  ),
  _Quote(
    clientName: 'Maria Fernanda',
    address: 'Alameda Santos, 88',
    service: 'Carga de gás refrigerante R410A',
    dateLabel: '12 Out, 15:30',
    valueCents: 22000,
    status: _QuoteStatus.refused,
  ),
  _Quote(
    clientName: 'João Batista',
    address: 'Rua dos Pinheiros, 350',
    service: 'Instalação Split 18.000 BTUs + tubulação',
    dateLabel: '11 Out, 11:00',
    valueCents: 165000,
    status: _QuoteStatus.sent,
  ),
];

class QuoteListScreen extends StatefulWidget {
  const QuoteListScreen({super.key});

  @override
  State<QuoteListScreen> createState() => _QuoteListScreenState();
}

class _QuoteListScreenState extends State<QuoteListScreen> {
  _Filter _selectedFilter = _Filter.all;
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    final filtered = _quotes.where(_selectedFilter.matches).toList();

    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Icon(Icons.build, color: AppColors.accent),
        ),
        title: const Text('ORÇAMENTOS'),
        actions: [
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
          const _GreetingRow(),
          const SizedBox(height: 16),
          const _SummaryCard(),
          const SizedBox(height: 20),
          _FilterBar(
            selected: _selectedFilter,
            onSelected: (filter) => setState(() => _selectedFilter = filter),
          ),
          const SizedBox(height: 16),
          if (filtered.isEmpty)
            const _EmptyState()
          else
            for (var i = 0; i < filtered.length; i++) ...[
              _QuoteCard(quote: filtered[i]),
              if (i != filtered.length - 1) const SizedBox(height: 12),
            ],
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        icon: const Icon(Icons.add),
        label: const Text('Novo orçamento'),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _navIndex,
        onDestinationSelected: (index) => setState(() => _navIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.description_outlined),
            selectedIcon: Icon(Icons.description),
            label: 'Orçamentos',
          ),
          NavigationDestination(
            icon: Icon(Icons.build_outlined),
            selectedIcon: Icon(Icons.build),
            label: 'Catálogo',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Clientes',
          ),
        ],
      ),
    );
  }
}

class _GreetingRow extends StatelessWidget {
  const _GreetingRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Olá, Carlos', style: Theme.of(context).textTheme.headlineMedium),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'OPERACIONAL',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard();

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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TOTAL EMITIDO EM OUTUBRO',
              style: textTheme.labelSmall?.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text('R\$ 18.450,00', style: textTheme.headlineLarge),
            const SizedBox(height: 4),
            Text(
              '14 orçamentos emitidos',
              style: textTheme.bodySmall?.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar({required this.selected, required this.onSelected});

  final _Filter selected;
  final ValueChanged<_Filter> onSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final filter in _Filter.values) ...[
          _FilterPill(
            filter: filter,
            count: _quotes.where(filter.matches).length,
            selected: selected == filter,
            onTap: () => onSelected(filter),
          ),
          if (filter != _Filter.values.last) const SizedBox(width: 8),
        ],
      ],
    );
  }
}

class _FilterPill extends StatelessWidget {
  const _FilterPill({
    required this.filter,
    required this.count,
    required this.selected,
    required this.onTap,
  });

  final _Filter filter;
  final int count;
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
          '${filter.label} ($count)',
          style: Theme.of(context).textTheme.labelMedium
              ?.copyWith(color: foreground),
        ),
      ),
    );
  }
}

class _QuoteCard extends StatelessWidget {
  const _QuoteCard({required this.quote});

  final _Quote quote;

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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(quote.clientName, style: textTheme.titleMedium),
                ),
                _StatusBadge(status: quote.status),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              quote.address,
              style: textTheme.bodySmall?.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            Text(quote.service, style: textTheme.bodyMedium),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    quote.dateLabel,
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ),
                Text(
                  _formatCurrency(quote.valueCents),
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

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final _QuoteStatus status;

  @override
  Widget build(BuildContext context) {
    final color = status.color;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            status.label,
            style: Theme.of(context).textTheme.labelSmall
                ?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

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
              child: const Icon(Icons.description_outlined, size: 32),
            ),
            const SizedBox(height: 16),
            Text('Nenhum orçamento cadastrado', style: textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              'Crie o primeiro orçamento direto na casa do cliente para enviar por WhatsApp ou PDF.',
              textAlign: TextAlign.center,
              style: textTheme.bodySmall?.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Criar primeiro orçamento'),
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
