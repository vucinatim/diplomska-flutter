import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_menu_flutter/src/blocs/profile_bloc/profile_bloc.dart';
import 'package:web_menu_flutter/src/models/models.dart';

import 'favorite_button.dart';

class RestaurantFavoriteButton extends StatelessWidget {
  const RestaurantFavoriteButton({Key? key, required this.restaurant})
      : super(key: key);

  final Restaurant restaurant;

  Future<bool> onFavoriteButtonTapped(
      BuildContext context, bool isFavorite) async {
    BlocProvider.of<ProfileBloc>(context).add(ToggleFavorite(restaurant));
    return !isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    final ProfileState state = context.watch<ProfileBloc>().state;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: state is ProfileLoaded
          ? FavoriteButton(
              size: 20,
              isFavorite: state.profile.favorites
                  .map((Restaurant r) => r.id)
                  .contains(restaurant.id),
              padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
              onTap: onFavoriteButtonTapped,
            )
          : const SizedBox.shrink(),
    );
  }
}
