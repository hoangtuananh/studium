# Add Category types to categories table
CategoryType.create! category_name: "Critical Reading"
CategoryType.create! category_name: "Math"
CategoryType.create! category_name: "Writing (Multiple Choice)"

QuestionType.create! type_name: "Sentence Completion",category_type: CategoryType.find_by_category_name!("Critical Reading")
QuestionType.create! type_name: "Reading",category_type: CategoryType.find_by_category_name!("Critical Reading")
QuestionType.create! type_name: "Sentence Improvement",category_type: CategoryType.find_by_category_name!("Writing (Multiple Choice)")
QuestionType.create! type_name: "Error Identification",category_type: CategoryType.find_by_category_name!("Writing (Multiple Choice)")
QuestionType.create! type_name: "Paragraph Improvement",category_type: CategoryType.find_by_category_name!("Writing (Multiple Choice)")
