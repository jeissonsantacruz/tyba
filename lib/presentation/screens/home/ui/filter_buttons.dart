import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tyba/presentation/screens/home/bloc/bloc.dart' as bloc;
import 'package:tyba/presentation/utils/constants.dart';

class FilterButtonsWidget extends StatelessWidget {
  final bloc.BookBloc blocProvider;
  const FilterButtonsWidget({Key? key, required this.blocProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<bloc.BookBloc, bloc.State>(
      bloc: blocProvider,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Wrap(
            spacing: 10,
            // list of chips
            children: [
              GestureDetector(
                child: Chip(
                  label: const Text(
                    kTitle,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  avatar: const Icon(
                    Icons.text_fields,
                    color: Colors.white,
                  ),
                  backgroundColor: !isSeleted(state.model.filter, kTitleKey)
                      ? Colors.purple
                      : Colors.black45,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                ),
                onTap: () =>
                    blocProvider.add(bloc.SelectFilterEvent(filter: kTitleKey)),
              ),
              GestureDetector(
                child: Chip(
                  label: const Text(
                    kAuthor,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  avatar: const Icon(
                    Icons.people_alt_sharp,
                    color: Colors.white,
                  ),
                  backgroundColor: !isSeleted(state.model.filter, kAuthorKey)
                      ? Colors.redAccent
                      : Colors.black45,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                ),
                onTap: () => blocProvider
                    .add(bloc.SelectFilterEvent(filter: kAuthorKey)),
              ),
              GestureDetector(
                child: Chip(
                  label: const Text(
                    kFree,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  avatar: const Icon(
                    Icons.search_off,
                    color: Colors.white,
                  ),
                  backgroundColor: !isSeleted(state.model.filter, kFreeKey)
                      ? Colors.lightBlueAccent
                      : Colors.black45,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                ),
                onTap: () =>
                    blocProvider.add(bloc.SelectFilterEvent(filter: kFreeKey)),
              ),
            ],
          ),
        );
      },
    );
  }

  bool isSeleted(String filter, String chip) {
    return filter == chip;
  }
}
