//
//  ExchangeRateListViewController.swift
//  CurrencyConverter
//
//  Created by afon.com on 13.09.2025.
//


//
//  ExchangeRateListViewController.swift
//  CurrencyConverter
//
//  Created by afon.com on 11.09.2025.
//
//
//import UIKit
//
//class ExchangeRateListViewController: UITableViewController {
//    
//    // MARK: - Properties
//    weak var delegate: ExchangeRateSelectionDelegate?
//    private var viewModel: ExchangeRateListViewModel!
//    
////    delegate — делегат, которому сообщаем, какую валюту выбрал пользователь.
////    Обычно это CurrencyConverterViewController.
////      viewModel — модель представления для списка валют. Хранит данные и бизнес-логику.
//    
//    // MARK: - Lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupViewModel()
//        setupUI()
//    }
//    
////    Когда экран загружается:
////    Настраивается viewModel.
////    Настраивается интерфейс таблицы и навигации.
//    // MARK: - Setup Methods
//    private func setupViewModel() {
//        viewModel = ExchangeRateListViewModel()
//        viewModel.delegate = self
//    }
//    
////    Создаём экземпляр ExchangeRateListViewModel.
////        Подписываемся на его события через делегат (чтобы контроллер узнавал о изменениях, если модель их поддерживает).
//  
//    private func setupUI() {
//        title = "Exchange Rate"
//        
//        // Настройка таблицы
//        tableView.backgroundColor = UIColor.systemBackground
//        tableView.separatorStyle = .singleLine
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 60
//        
//        // Добавляем кнопку назад если нужно
//        setupNavigationBar()
//    }
//    
//    private func setupNavigationBar() {
//        // Можно добавить дополнительные кнопки в навигацию
//        navigationItem.rightBarButtonItem = UIBarButtonItem(
//            barButtonSystemItem: .refresh,
//            target: self,
//            action: #selector(refreshData)
//        )
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
//    }
//
//    
//    // MARK: - Actions
//    @objc private func refreshData() {
//        viewModel.refresh()
//        tableView.reloadData()
//    }
//    
////    Обновляем данные через viewModel.
////    Перезагружаем таблицу.
//    
//    // MARK: - Table view data source
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.numberOfItems
//    }
////    В таблице 1 секция.
////    Количество строк берём из viewModel.numberOfItems.
//    
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cellViewModel = viewModel.cellViewModel(at: indexPath.row) else {
//            return UITableViewCell()
//        }
////        Создаём ячейку для каждой валюты:
////        Берём cellViewModel из viewModel.
////        Настраиваем текст, курс и стиль ячейки.
//        
//        
//        // Используем базовую ячейку, но можно создать кастомную
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell") 
//                   ?? UITableViewCell(style: .value1, reuseIdentifier: "CurrencyCell")
//        
//        configureCell(cell, with: cellViewModel)
//        
//        return cell
//    }
//    
//    private func configureCell(_ cell: UITableViewCell, with cellViewModel: ExchangeRateCellViewModel) {
//        cell.textLabel?.text = cellViewModel.displayText
//        cell.detailTextLabel?.text = cellViewModel.rateText
//        cell.accessoryType = .disclosureIndicator
//        
//        // Дополнительное оформление
////        cell.textLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
////        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
////        cell.detailTextLabel?.textColor = .systemBlue
//    }
//    
//    // MARK: - Table view delegate
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        
//        viewModel.selectItem(at: indexPath.row)
//        navigationController?.popViewController(animated: true)
//    }
//    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Доступные валюты"
//    }
//    
//    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//        return viewModel.isEmpty ? "Нет доступных валют" : nil
//    }
//}
//
//// MARK: - Exchange Rate Selection Delegate
//extension ExchangeRateListViewController: ExchangeRateSelectionDelegate {
//    func didSelectCurrency(_ currency: Currency) {
//        delegate?.didSelectCurrency(currency)
//    }
//}
