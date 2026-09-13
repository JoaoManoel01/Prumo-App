import 'package:flutter/material.dart';

import '../components/step_progress.dart';
import '../theme/app_colors.dart';
import 'new_quote_items_screen.dart';

class _Client {
  const _Client({
    required this.name,
    required this.address,
    required this.lastService,
    this.tag,
  });

  final String name;
  final String address;
  final String lastService;
  final String? tag;
}

const List<_Client> _clients = [
  _Client(
    name: 'Roberto Silveira',
    address: 'Jardim das Flores • São Paulo',
    lastService: 'Último serviço: 18 de Outubro',
    tag: 'Recorrente',
  ),
  _Client(
    name: 'Ana Paula Mendes',
    address: 'Bairro Mooca • São Paulo',
    lastService: 'Último serviço: 03 de Setembro',
  ),
  _Client(
    name: 'Condomínio Lar das Flores',
    address: 'Portaria Central • Vila Mariana',
    lastService: 'Último serviço: 29 de Agosto',
    tag: 'Comercial',
  ),
  _Client(
    name: 'Marcos Andrade',
    address: 'Rua Augusta, 1420 • Consolação',
    lastService: 'Último serviço: 14 de Julho',
  ),
];

class NewQuoteCustomerScreen extends StatefulWidget {
  const NewQuoteCustomerScreen({super.key});

  @override
  State<NewQuoteCustomerScreen> createState() => _NewQuoteCustomerScreenState();
}

class _NewQuoteCustomerScreenState extends State<NewQuoteCustomerScreen> {
  _Client? _selected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.of(context).pop()),
        title: const Text('Novo Orçamento'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'FLUXO DE TRABALHO',
                      style: textTheme.labelSmall?.copyWith(
                        color: AppColors.accent,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text('Etapa 1 de 3', style: textTheme.labelSmall),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const StepProgress(currentStep: 1, totalSteps: 3),
                const SizedBox(height: 16),
                Text(
                  'Quem é o cliente deste serviço?',
                  style: textTheme.headlineMedium,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'Selecione na lista de registros ou cadastre um novo cliente no local.',
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 12),
                const TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Buscar cliente por nome ou telefone...',
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.person_add_alt_1),
                  label: const Text('Cadastrar novo cliente'),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'CLIENTES RECENTES (${_clients.length})',
                      style: textTheme.labelSmall?.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Ordem de visita',
                      style: textTheme.labelSmall?.copyWith(
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                for (var i = 0; i < _clients.length; i++) ...[
                  _ClientCard(
                    client: _clients[i],
                    selected: _selected == _clients[i],
                    onTap: () => setState(() => _selected = _clients[i]),
                  ),
                  if (i != _clients.length - 1) const SizedBox(height: 8),
                ],
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Cliente ativo: ${_selected?.name ?? '—'}',
                      style: textTheme.bodySmall,
                    ),
                  ),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: _selected == null
                        ? null
                        : () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const NewQuoteItemsScreen(),
                            ),
                          ),
                    child: const Text('Continuar para Serviços'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ClientCard extends StatelessWidget {
  const _ClientCard({
    required this.client,
    required this.selected,
    required this.onTap,
  });

  final _Client client;
  final bool selected;
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
        side: BorderSide(
          color: selected ? AppColors.accent : AppColors.outlineVariant,
          width: selected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: selected
                    ? AppColors.accent
                    : AppColors.surfaceContainerHigh,
                foregroundColor: selected
                    ? AppColors.onPrimary
                    : AppColors.onSurface,
                child: Text(_initials(client.name)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            client.name,
                            style: textTheme.titleMedium,
                          ),
                        ),
                        if (client.tag != null) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainerHigh,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              client.tag!,
                              style: textTheme.labelSmall,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      client.address,
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      client.lastService,
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                selected ? Icons.check_circle : Icons.radio_button_unchecked,
                color: selected ? AppColors.accent : AppColors.outlineVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _initials(String name) {
  final parts = name.split(' ').where((part) => part.isNotEmpty).toList();
  if (parts.isEmpty) return '?';
  final first = parts.first[0];
  final second = parts.length > 1 ? parts[1][0] : '';
  return '$first$second'.toUpperCase();
}
