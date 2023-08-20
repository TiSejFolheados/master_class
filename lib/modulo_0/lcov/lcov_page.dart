import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_class/modulo_0/lcov/lcov_bloc.dart';
import 'package:master_class/modulo_0/lcov/lcov_bloc_event.dart';
import 'package:master_class/modulo_0/lcov/lcov_bloc_state.dart';
import 'package:master_class/util/widget/appbar_default.dart';
import 'package:master_class/util/widget/card_result.dart';

class LcovPage extends StatelessWidget {
  const LcovPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LcovBloc()..add(LcovLoad()),
        child: Scaffold(
          appBar: const AppBarDefault("Lcov").build(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  const Text("Leitura do arquivo Coverage/lcov.info"),
                  BlocBuilder<LcovBloc, LcovState>(
                    builder: (context, state) {
                      if (state is LcovStateLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (state is LcovStateError) {
                        return CardResult.error(text: state.error);
                      }

                      if (state is LcovStateLoaded) {
                        final fileReports = state.lcov.fileReports;
                        return Column(
                          children: [
                            CardResult.valid(text: "Coverage de ${state.lcov.coverage().toString()}%"),
                            Card(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: fileReports.length,
                                  itemBuilder: (context, index) {
                                    final fileReport = fileReports[index];
                                    final isVerify = fileReport.linesVerify.isNotEmpty;
                                    return Column(
                                      children: [
                                        ListTile(
                                          title: Text(fileReport.sourceFile),
                                          trailing: isVerify
                                              ? const Icon(Icons.warning, color: Colors.amber)
                                              : const Icon(Icons.check, color: Colors.green),
                                          subtitle: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Lines Found: ${fileReport.linesFound} - Lines Hit: ${fileReport.linesHit}"),
                                              isVerify ? Text("Lines Verify: ${fileReport.linesVerify.join("-")}") : Container(),
                                            ],
                                          ),
                                        ),
                                        index != fileReports.length - 1 ? const Divider() : Container(),
                                      ],
                                    );
                                  }),
                            ),
                          ],
                        );
                      }

                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
