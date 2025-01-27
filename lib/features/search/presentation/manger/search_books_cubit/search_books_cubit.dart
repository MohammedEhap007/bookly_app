import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../home/data/models/book_model/book_model.dart';
import '../../../../home/data/repos/home_repo.dart';

part 'search_books_state.dart';

class SearchBooksCubit extends Cubit<SearchBooksState> {
  SearchBooksCubit(this.homeRepo) : super(SearchBooksInitial());

  final HomeRepo homeRepo;

  Future<void> searchBooks({required String query}) async {
    emit(SearchBooksLoading());
    var result = await homeRepo.searchBooks(query: query);
    result.fold(
      (failure) {
        emit(
          SearchBooksFailure(failure.errorMessage),
        );
      },
      (books) {
        emit(
          SearchBooksSuccess(books),
        );
      },
    );
  }
}
