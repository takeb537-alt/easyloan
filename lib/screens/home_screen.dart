Widget _buildLoanGrid(int onTimePayments) {
  return GridView.builder(
    shrinkWrap: true,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
    itemCount: loanAmounts.length,
    itemBuilder: (context, index) {
      int amount = loanAmounts[index];
      bool isLocked = true;

      if (amount <= 200) isLocked = false;
      else if (amount <= 1000 && onTimePayments >= 3) isLocked = false;
      else if (amount <= 2000 && onTimePayments >= 6) isLocked = false;

      return Card(
        color: isLocked ? Colors.grey[300] : Colors.blue[100],
        child: InkWell(
          onTap: isLocked ? null : () => _applyLoan(amount),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLocked) Icon(Icons.lock, size: 16),
              Text("₹$amount", style: TextStyle(fontWeight: FontWeight.bold)),
              if (isLocked) Text("Locked", style: TextStyle(fontSize: 10)),
            ],
          ),
        ),
      );
    },
  );
}
