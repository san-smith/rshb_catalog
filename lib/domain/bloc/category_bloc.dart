import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rshb_catalog/domain/model/category.dart';
import 'package:rshb_catalog/domain/repository/category_repository.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository;

  CategoryBloc(this._categoryRepository);

  List<Category> _categories = [];

  @override
  get initialState => CategoryInitialState();

  @override
  Stream<CategoryState> mapEventToState(event) async* {
    if (event is CategoryInitEvent) {
      yield* _mapCategoryInitEventToState();
    } else if (event is CategoryChangeSectionEvent) {
      yield* _mapCategoryChangeSectionEventToState(event);
    }
  }

  Stream<CategoryState> _mapCategoryInitEventToState() async* {
    yield CategoryLoadingState();
    try {
      _categories = await _categoryRepository.getCategories();
      final categories = _categories.where((it) => it.sectionId == 1).toList();
      yield CategoryReadyState(categories);
    } catch (e) {
      yield CategoryErrorState(e.toString());
    }
  }

  Stream<CategoryState> _mapCategoryChangeSectionEventToState(
      CategoryChangeSectionEvent event) async* {
    final categories =
        _categories.where((it) => it.sectionId == event.sectionId).toList();
    yield CategoryReadyState(categories);
  }
}

// states

abstract class CategoryState {}

class CategoryInitialState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryReadyState extends CategoryState {
  final List<Category> categories;

  CategoryReadyState(this.categories);
}

class CategoryErrorState extends CategoryState {
  final String message;

  CategoryErrorState(this.message);
}

// events

abstract class CategoryEvent {}

class CategoryInitEvent extends CategoryEvent {}

class CategoryChangeSectionEvent extends CategoryEvent {
  final int sectionId;

  CategoryChangeSectionEvent(this.sectionId);
}
