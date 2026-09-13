import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class _DocumentRow {
  const _DocumentRow(this.description, this.qty, this.unit, this.total);
  final String description;
  final String qty;
  final String unit;
  final String total;
}

class NewQuotePreviewScreen extends StatelessWidget {
  const NewQuotePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.of(context).pop()),
        title: const Text('Prévia do Orçamento'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'ETAPA 3 DE 3',
            style: textTheme.labelSmall?.copyWith(color: AppColors.accent),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.outlineVariant),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('CLIMATECH REFRIGERAÇÃO', style: textTheme.titleMedium),
                Text(
                  'Marcio Silva • Técnico Responsável',
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                Text(
                  'CNPJ: 42.189.583/0001-82 • CRT: 94103',
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'ORÇAMENTO',
                        style: textTheme.labelSmall?.copyWith(
                          color: AppColors.success,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text('#ORC-0482', style: textTheme.labelMedium),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _Section(
            title: 'DESTINATÁRIO / CLIENTE',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Roberto Silveira', style: textTheme.titleMedium),
                Text('(11) 98744-2190', style: textTheme.bodyMedium),
                Text('roberto.silveira@email.com', style: textTheme.bodyMedium),
                Text(
                  'Rua das Acácias, 412 - Apt 82\nJardim das Flores - SP',
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _Section(
            title: 'SERVIÇOS / MÃO DE OBRA',
            child: _DocumentTable(
              rows: const [
                _DocumentRow(
                  'Instalação Split Inverter 12.000 BTUs',
                  '1 un',
                  '450,00',
                  'R\$ 450,00',
                ),
                _DocumentRow(
                  'Passagem tubulação e furação técnica',
                  '2 m',
                  '100,00',
                  'R\$ 200,00',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _Section(
            title: 'PEÇAS E MATERIAIS APLICADOS',
            child: _DocumentTable(
              rows: const [
                _DocumentRow(
                  'Suporte reforçado condensadora 450mm',
                  '1 par',
                  '118,00',
                  'R\$ 118,00',
                ),
                _DocumentRow(
                  'Tubo cobre 1/4 e 3/8 c/ isolamento',
                  '3 m',
                  '248,00',
                  'R\$ 744,00',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _Section(
            title: 'RESUMO FINANCEIRO',
            child: Column(
              children: [
                _SummaryLine(label: 'Soma Mão de Obra', value: 'R\$ 650,00'),
                _SummaryLine(label: 'Soma Materiais', value: 'R\$ 862,00'),
                _SummaryLine(label: 'Desconto concedido', value: 'R\$ 0,00'),
                const Divider(),
                Row(
                  children: [
                    Text('VALOR TOTAL', style: textTheme.labelLarge),
                    const Spacer(),
                    Text('R\$ 1.512,00', style: textTheme.headlineMedium),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Em até 3x sem juros no cartão ou via Pix',
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _Section(
            title: 'VALIDADE & OBSERVAÇÕES',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Validade da Proposta: 10 dias úteis',
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  '• Garantia padrão de 90 dias sobre o serviço prestado.\n'
                  '• Ponto de força elétrica 220V deve estar disponível.\n'
                  '• Não inclui alvenaria fina, gesso ou pintura.',
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.chat),
                  label: const Text('WhatsApp'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.share),
                  label: const Text('Compartilhar'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit_note),
                  label: const Text('Rascunho'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelSmall
              ?.copyWith(color: AppColors.onSurfaceVariant),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

class _DocumentTable extends StatelessWidget {
  const _DocumentTable({required this.rows});

  final List<_DocumentRow> rows;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        for (var i = 0; i < rows.length; i++) ...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(rows[i].description, style: textTheme.bodyMedium),
              const SizedBox(height: 2),
              Text(
                '${rows[i].qty} x ${rows[i].unit}',
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Align(
                alignment: Alignment.centerRight,
                child: Text(rows[i].total, style: textTheme.bodyMedium),
              ),
            ],
          ),
          if (i != rows.length - 1) const Divider(),
        ],
      ],
    );
  }
}

class _SummaryLine extends StatelessWidget {
  const _SummaryLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
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
      ),
    );
  }
}
