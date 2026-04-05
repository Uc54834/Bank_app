import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../components/app_cards.dart';
import '../components/primary_button.dart';
import '../services/exchange_service.dart';
import '../services/account_service.dart';
import '../utils/responsive.dart';
import 'home_page.dart';

class ExchangePage extends StatefulWidget {
  const ExchangePage({super.key});

  @override
  State<ExchangePage> createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {
  String fromCurrency = 'USD';
  String toCurrency = 'EUR';
  String inputAmount = '';
  String convertedAmount = '0.00';
  bool isLoading = false;
  double fee = 0.0;
  double balance = 0.0;
  String? errorMessage;

  final List<Currency> currencies = ExchangeService.getAvailableCurrencies();

  @override
  void initState() {
    super.initState();
    _loadBalance();
  }

  Future<void> _loadBalance() async {
    final bal = await AccountService.getBalance();
    setState(() => balance = bal);
  }

  void _calculateConversion() {
    if (inputAmount.isEmpty) {
      setState(() {
        convertedAmount = '0.00';
        fee = 0.0;
        errorMessage = null;
      });
      return;
    }

    final amount = double.tryParse(inputAmount) ?? 0.0;

    // Validate against minimum balance
    final validation = AccountService.validateWithdrawal(amount);
    if (validation != null) {
      setState(() {
        errorMessage = validation;
        convertedAmount = '0.00';
        fee = 0.0;
      });
      return;
    }

    final result = ExchangeService.convert(amount, fromCurrency, toCurrency);
    final exchangeFee = ExchangeService.calculateFee(amount);

    setState(() {
      convertedAmount = result.toStringAsFixed(2);
      fee = exchangeFee;
      errorMessage = null;
    });
  }

  void _onKeyPressed(String key) {
    setState(() {
      if (key == 'X') {
        if (inputAmount.isNotEmpty) {
          inputAmount = inputAmount.substring(0, inputAmount.length - 1);
        }
      } else if (key == '.') {
        if (!inputAmount.contains('.')) {
          inputAmount += key;
        }
      } else if (inputAmount.length < 10) {
        inputAmount += key;
      }
      _calculateConversion();
    });
  }

  void _swapCurrencies() {
    setState(() {
      final temp = fromCurrency;
      fromCurrency = toCurrency;
      toCurrency = temp;
      _calculateConversion();
    });
  }

  Future<void> _performExchange() async {
    final amount = double.tryParse(inputAmount) ?? 0.0;

    // Validate amount
    final validation = AccountService.validateWithdrawal(amount);
    if (validation != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(validation)));
      return;
    }

    setState(() => isLoading = true);

    try {
      final converted = double.tryParse(convertedAmount) ?? 0.0;

      // Record the exchange
      await ExchangeService.recordExchange(
        amount: amount,
        fromCurrency: fromCurrency,
        toCurrency: toCurrency,
        convertedAmount: converted,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Exchange completed successfully!')),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Exchange failed: $e')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final redeemable = AccountService.getMaximumRedeemable();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Currency Exchange',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Balance display
              AppCard(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Available Balance',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          AccountService.formatBalance(balance),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Divider(),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Redeemable Amount',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          AccountService.formatBalance(redeemable),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Minimum Balance (Bank Cost)',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          AccountService.formatBalance(
                            AccountService.getMinimumBalance(),
                          ),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Currency Selector
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _currencyDropdown(fromCurrency, (val) {
                    setState(() {
                      fromCurrency = val!;
                      _calculateConversion();
                    });
                  }, AppColors.primary),
                  IconButton(
                    icon: const Icon(
                      Icons.swap_horiz,
                      size: 32,
                      color: AppColors.primary,
                    ),
                    onPressed: _swapCurrencies,
                  ),
                  _currencyDropdown(toCurrency, (val) {
                    setState(() {
                      toCurrency = val!;
                      _calculateConversion();
                    });
                  }, AppColors.secondary),
                ],
              ),
              const SizedBox(height: 32),
              // Amount Fields
              AppCard(
                child: Column(
                  children: [
                    _amountField(
                      'FROM',
                      fromCurrency,
                      inputAmount.isEmpty ? '0.00' : inputAmount,
                    ),
                    const Divider(height: 32),
                    _amountField(
                      'TO',
                      toCurrency,
                      convertedAmount,
                      isReadOnly: true,
                    ),
                  ],
                ),
              ),
              // Error message
              if (errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    errorMessage!,
                    style: const TextStyle(
                      color: AppColors.error,
                      fontSize: 12,
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              // Fee display
              if (fee > 0)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Exchange Fee (1%)',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        AccountService.formatBalance(fee),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 24),
              // Keypad
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.8,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  final keys = [
                    '1',
                    '2',
                    '3',
                    '4',
                    '5',
                    '6',
                    '7',
                    '8',
                    '9',
                    '.',
                    '0',
                    'X',
                  ];
                  return _keypadButton(keys[index]);
                },
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                text: 'EXCHANGE NOW',
                onPressed: isLoading || errorMessage != null
                    ? null
                    : _performExchange,
                isLoading: isLoading,
              ),
              const SizedBox(height: 16),
              // Exchange rate info
              Center(
                child: Text(
                  '1 ${Currency.getByCode(fromCurrency).code} = ${ExchangeService.getRate(fromCurrency, toCurrency).toStringAsFixed(4)} ${Currency.getByCode(toCurrency).code}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _currencyDropdown(
    String value,
    ValueChanged<String?> onChanged,
    Color color,
  ) {
    final currency = Currency.getByCode(value);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton<String>(
        value: value,
        underline: const SizedBox(),
        onChanged: onChanged,
        items: currencies.map((c) {
          return DropdownMenuItem(
            value: c.code,
            child: Text('${c.code} (${c.symbol})'),
          );
        }).toList(),
      ),
    );
  }

  Widget _amountField(
    String label,
    String currency,
    String value, {
    bool isReadOnly = false,
  }) {
    final curr = Currency.getByCode(currency);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.primaryContainer,
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(12),
                ),
              ),
              child: Text(
                curr.symbol,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
            Expanded(
              child: TextFormField(
                initialValue: value,
                readOnly: isReadOnly,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  filled: !isReadOnly,
                  fillColor: isReadOnly
                      ? Colors.transparent
                      : AppColors.surface,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.horizontal(
                      right: Radius.circular(12),
                    ),
                    borderSide: BorderSide(
                      color: isReadOnly
                          ? Colors.transparent
                          : AppColors.outline,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.horizontal(
                      right: Radius.circular(12),
                    ),
                    borderSide: BorderSide(
                      color: isReadOnly
                          ? Colors.transparent
                          : AppColors.outline,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _keypadButton(String text) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: text == 'X'
            ? AppColors.accentContainer
            : AppColors.primary,
        foregroundColor: text == 'X' ? AppColors.accent : Colors.white,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () => _onKeyPressed(text),
      child: Text(
        text == 'X' ? '⌫' : text,
        style: TextStyle(
          fontSize: text == 'X' ? 20 : 24,
          fontWeight: FontWeight.w600,
          color: text == 'X' ? AppColors.accent : Colors.white,
        ),
      ),
    );
  }
}
