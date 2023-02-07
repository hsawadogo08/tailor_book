import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:tailor_book/bloc/filter/filter_bloc.dart';
import 'package:tailor_book/bloc/personnel/personnel.bloc.dart';
import 'package:tailor_book/constants/color.dart';
import 'package:tailor_book/models/personnel.model.dart';
import 'package:tailor_book/pages/personnels/add_personnel.page.dart';
import 'package:tailor_book/pages/personnels/detail_personnel.page.dart';
import 'package:tailor_book/widgets/personnel/personnel_item.widget.dart';
import 'package:tailor_book/widgets/shared/custom_button.widget.dart';
import 'package:tailor_book/widgets/shared/custom_search_text_field.dart';
import 'package:tailor_book/widgets/shared/loadingSpinner.dart';

class PersonnelPage extends StatefulWidget {
  const PersonnelPage({super.key});

  @override
  State<PersonnelPage> createState() => _PersonnelPageState();
}

class _PersonnelPageState extends State<PersonnelPage> {
  @override
  void initState() {
    super.initState();
    context.read<PersonnelBloc>().add(SearchPersonnelEvent());
    context.read<FilterBloc>().add(SearchFilterkeyEvent(searchKey: ""));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(2),
        child: Container(
          color: primaryColor,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          MaterialPageRoute route = MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) {
              return const AddPersonnelPage();
            },
          );
          Navigator.push(context, route).then((value) {
            if (value == true) {
              context.read<PersonnelBloc>().add(SearchPersonnelEvent());
            }
          });
        },
        backgroundColor: secondaryColor,
        tooltip: 'Nouveau personnel',
        child: const Icon(
          Icons.person_add,
          size: 35,
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: primaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mon Personnel",
                    style: GoogleFonts.exo2(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: kWhite,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomSearchTextField(
                    onSearch: (searchKey) {
                      context.read<FilterBloc>().add(
                            SearchFilterkeyEvent(
                              searchKey: searchKey,
                            ),
                          );
                    },
                  ),
                ],
              ),
            ),
            BlocBuilder<FilterBloc, FilterState>(
              builder: (filterContext, filterState) {
                String filterKey = "";
                if (filterState is SearchFilterkeyState) {
                  filterKey = filterState.searchKey;
                }
                return Expanded(
                  child: BlocBuilder<PersonnelBloc, PersonnelStates>(
                    builder: (context, state) {
                      if (state is PersonnelLoadingState) {
                        return const LoadingSpinner();
                      } else if (state is PersonnelErrorState) {
                        return errorSection(state.errorMessage, context);
                      } else if (state is SearchPersonnelSuccessState) {
                        if (state.personnels.isEmpty) {
                          return emptySection(
                            "Vous n'avez pas enregistré un personnel !",
                          );
                        }

                        List<Personnel> personnels = state.personnels.where(
                          (element) {
                            String name =
                                "${element.firstName}${element.lastName}${element.phoneNumber}";
                            return name
                                .toUpperCase()
                                .contains(filterKey.toUpperCase());
                          },
                        ).toList();

                        if (personnels.isEmpty) {
                          return emptySection(
                            "Aucun personnel trouvé !",
                          );
                        }

                        return LazyLoadScrollView(
                          onEndOfPage: () {},
                          child: ListView.builder(
                            itemCount: personnels.length,
                            itemBuilder: (builderContext, index) {
                              return GestureDetector(
                                onTap: () async {
                                  bool? response = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return DetailPersonnelPage(
                                          personnel: personnels[index],
                                        );
                                      },
                                    ),
                                  );
                                  if (response == true) {
                                    // ignore: use_build_context_synchronously
                                    context
                                        .read<PersonnelBloc>()
                                        .add(SearchPersonnelEvent());
                                  }
                                },
                                child: PersonnelItem(
                                  personnel: personnels[index],
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget errorSection(String errorMessage, BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 75,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                errorMessage,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: kWhite,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          CustomButton(
            buttonText: "Réessayer",
            btnTextColor: kWhite,
            buttonSize: 18,
            buttonColor: secondaryColor,
            borderColor: secondaryColor,
            buttonFonction: () {
              context.read<PersonnelBloc>().add(SearchPersonnelEvent());
            },
          ),
        ],
      ),
    );
  }

  Widget emptySection(String message) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 75,
            decoration: BoxDecoration(
              color: tertiaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                message,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: kWhite,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
