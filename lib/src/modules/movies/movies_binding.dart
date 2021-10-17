import 'package:get/get.dart';
import 'package:practica2/src/data/repositories/movie_repository.dart';
import 'package:practica2/src/modules/movies/movies_controller.dart';
import 'package:practica2/src/data/services/movie_service.dart';

class MoviesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoviesController>(() => MoviesController(
          movieService: MovieService(),
          movieRepository: MovieRepository(),
        ));
  }
}
