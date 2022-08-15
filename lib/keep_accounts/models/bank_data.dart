class BankData {
  BankData({
    this.key = '',
    this.name = '',
    this.logo = ''
  });

  String key;
  String name;
  String logo;

  static List<BankData> tabIconsList = <BankData>[
    BankData(
      key: 'assets/fitness_app/Kd6atO.png',
      name: 'Breakfast',
      logo: '#FA7D82',
    )
  ];
}
