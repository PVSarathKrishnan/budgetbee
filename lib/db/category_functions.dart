import 'package:budgetbee/model/category_model.dart';

import 'package:hive/hive.dart';

class CategoryFunctions {
  static const String expenseBoxName = 'expense_categories';
  static const String incomeBoxName = 'income_categories';

  Future<void> setupCategories() async {
    final expenseCategoryBox =
        await Hive.openBox<CategoryModel>(expenseBoxName);
    final incomeCategoryBox = await Hive.openBox<CategoryModel>(incomeBoxName);

    await _addDefaultExpenseCategories(expenseCategoryBox);
    await _addDefaultIncomeCategories(incomeCategoryBox);
  }

  Future<void> setupAndOpenCategories() async {
    // Create an instance of CategoryFunctions and setup categories
    final categoryFunctions = CategoryFunctions();
    await categoryFunctions.setupCategories();
  }

  Future<void> _addDefaultExpenseCategories(Box<CategoryModel> box) async {
    final existingCategories = getExpenseCategories();

    final defaultExpenseCategories = [
      "Food",
      "Transportation",
      "Housing",
      "Utilities",
      "Health",
      "Entertainment",
      "Shopping",
      "Debt Payments",
      "Education",
      "Travel",
      "Insurance",
      "Personal Care",
      "Charity",
      "Miscellaneous",
    ];

    for (var category in defaultExpenseCategories) {
      if (!existingCategories.any(
          (element) => element.name.toLowerCase() == category.toLowerCase())) {
        final categoryModel = CategoryModel(name: category, type: 'Expense');
        await box.add(categoryModel);
        print('Added default expense category: $category');
      } else {
        print('Expense category already exists: $category');
      }
    }
  }

  Future<void> _addDefaultIncomeCategories(Box<CategoryModel> box) async {
    final existingCategories = getIncomeCategories();

    final defaultIncomeCategories = [
      "Salary",
      "Freelancing",
      "Investments",
      "Rental Income",
      "Business Profit",
      "Gifts",
      "Prizes",
      "Other Income"
    ];

    for (var category in defaultIncomeCategories) {
      if (!existingCategories.any(
          (element) => element.name.toLowerCase() == category.toLowerCase())) {
        final categoryModel = CategoryModel(name: category, type: 'Income');
        await box.add(categoryModel);
        print('Added default income category: $category');
      } else {
        print('Income category already exists: $category');
      }
    }
  }

// Method to retrieve expense categories
  List<CategoryModel> getExpenseCategories() {
    final expenseCategoryBox = Hive.box<CategoryModel>(expenseBoxName);
    final List<CategoryModel> expenseCategories =
        expenseCategoryBox.values.toList();
    return List<CategoryModel>.from(
        expenseCategories); // Creates a new instance
  }

// Method to retrieve income categories
  List<CategoryModel> getIncomeCategories() {
    final incomeCategoryBox = Hive.box<CategoryModel>(incomeBoxName);
    final List<CategoryModel> incomeCategories =
        incomeCategoryBox.values.toList();
    return List<CategoryModel>.from(incomeCategories); // Creates a new instance
  }

  Future<void> addCategoryToDefaultList(String category, String type) async {
    final incomeCategoryBox = Hive.box<CategoryModel>(incomeBoxName);
    final expenseCategoryBox = Hive.box<CategoryModel>(expenseBoxName);

    final categoryModel =
        CategoryModel(name: category, type: type.toLowerCase());

    // Get the appropriate box based on the type
    final Box<CategoryModel> box =
        type.toLowerCase() == 'income' ? incomeCategoryBox : expenseCategoryBox;

    // Check if the category already exists before adding it
    final existingCategories = box.values.toList();
    final categoryExists = existingCategories.any((element) =>
        element.name.toLowerCase() == category.toLowerCase() &&
        element.type.toLowerCase() == type.toLowerCase());

    if (!categoryExists) {
      await box.add(categoryModel);
      print('Category added: $categoryModel');
    } else {
      print('Category already exists: $categoryModel');
    }
  }
}
