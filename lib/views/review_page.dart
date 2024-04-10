import 'package:flutter/material.dart';
import 'package:myapp/models/movie.dart';

class ReviewPage extends StatelessWidget {
  final Movie movie;
  final TextEditingController ratingController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();

  // Adiciona um GlobalKey para o formulário
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ReviewPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Write your review"),
      ),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Form(
          key: _formKey, // Define a chave do formulário aqui
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: ratingController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 8),
                              labelText: 'Your rating (1-10)',
                              labelStyle: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a rating';
                              } else if (double.parse(value) < 1 ||
                                  double.parse(value) > 10) {
                                return 'Rating must be between 1 - 10';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Image.asset(
                      movie.image,
                      width: 160,
                      height: 200,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  controller: reviewController,
                  maxLines: 8,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: 'Write down your review...',
                    labelStyle: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Review published successfully"),
                          ),
                        );
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.only(right: 16, left: 16),
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text("Publish"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
