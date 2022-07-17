import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tyba/presentation/screens/home/bloc/bloc.dart' as bloc;

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
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: Wrap(
            spacing: 10,
            // list of chips
            children: [
              GestureDetector(
                child: Chip(
                  label: const Text('Title'),
                  avatar: const Icon(
                    Icons.work,
                    color: Colors.red,
                  ),
                  backgroundColor: isSeleted(state.model.filter, 'title')
                      ? Colors.amberAccent
                      : Colors.blueGrey,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                ),
                onTap: () =>
                    blocProvider.add(bloc.SelectFilterEvent(filter: 'title')),
              ),
              GestureDetector(
                child: Chip(
                  label: const Text('Author'),
                  avatar: const Icon(
                    Icons.work,
                    color: Colors.red,
                  ),
                  backgroundColor: isSeleted(state.model.filter, 'author')
                      ? Colors.amberAccent
                      : Colors.blueGrey,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                ),
                onTap: () =>
                    blocProvider.add(bloc.SelectFilterEvent(filter: 'author')),
              ),
              GestureDetector(
                child: Chip(
                  label: const Text('Free'),
                  avatar: const Icon(
                    Icons.work,
                    color: Colors.red,
                  ),
                  backgroundColor: isSeleted(state.model.filter, 'q')
                      ? Colors.amberAccent
                      : Colors.blueGrey,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                ),
                onTap: () =>
                    blocProvider.add(bloc.SelectFilterEvent(filter: 'q')),
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
