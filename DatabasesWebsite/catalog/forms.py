from django import forms

class CatalogForm(forms.Form):
	search_term = forms.CharField(label='Search', max_length=100, required=False)
	filter_choice = forms.ChoiceField(label='', choices=[("All", "All")] + [("Books", "Books")] + [("Movies", "Movies")] + [("Music", "Music")])