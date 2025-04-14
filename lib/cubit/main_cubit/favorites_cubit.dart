import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
//this is the model
class FavoriteItem extends Equatable {
  final int id;
  final String name;
  final String image;
  final String price;
  final String description;
  final double rating;

  const FavoriteItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.rating,
  });

  @override
  List<Object?> get props => [id, name, image, price, description, rating];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image,
    'price': price,
    'description': description,
    'rating': rating,
  };

  factory FavoriteItem.fromJson(Map<String, dynamic> json) => FavoriteItem(
    id: json['id'],
    name: json['name'],
    image: json['image'],
    price: json['price'],
    description: json['description'],
    rating: (json['rating'] as num).toDouble(),
  );
}

// State
abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}
// the state and the cubit are here no idea why ???
class FavoritesInitial extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<FavoriteItem> favorites;

  const FavoritesLoaded({required this.favorites});

  @override
  List<Object> get props => [favorites];
}
// the cubit for the Favorite screen
class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesLoaded(favorites: [])) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('favorites');
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      final loadedFavorites = jsonList.map((json) => FavoriteItem.fromJson(json)).toList();
      emit(FavoritesLoaded(favorites: loadedFavorites));
    }
  }

  Future<void> toggleFavorite(FavoriteItem item) async {
    if (state is FavoritesLoaded) {
      final currentFavorites = (state as FavoritesLoaded).favorites;
      final isAlreadyFav = currentFavorites.any((fav) => fav.id == item.id);

      final updatedFavorites = isAlreadyFav
          ? currentFavorites.where((fav) => fav.id != item.id).toList()
          : [...currentFavorites, item];

      emit(FavoritesLoaded(favorites: updatedFavorites));

      await _saveFavorites(updatedFavorites);
    }
  }

  Future<void> _saveFavorites(List<FavoriteItem> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = favorites.map((item) => item.toJson()).toList();
    await prefs.setString('favorites', jsonEncode(jsonList));
  }

  bool isFavorite(FavoriteItem item) {
    if (state is FavoritesLoaded) {
      return (state as FavoritesLoaded)
          .favorites
          .any((fav) => fav.id == item.id);
    }
    return false;
  }
}

