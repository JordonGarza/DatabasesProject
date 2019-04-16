# users/models.py
from django.contrib.auth.models import AbstractUser
from django.db import models



class CustomUser(AbstractUser):
    # add additional fields in here
    REQUIRED_FIELDS = ['first_name','last_name']
    def __str__(self):
        return self.username

class Book(models.Model):
    isbn = models.CharField(db_column='ISBN', primary_key=True, max_length=13)  # Field name made lowercase.
    title = models.CharField(db_column='Title', max_length=30, blank=True, null=True)  # Field name made lowercase.
    author = models.CharField(db_column='Author', max_length=30, blank=True, null=True)  # Field name made lowercase.
    genre = models.CharField(db_column='Genre', max_length=8, blank=True, null=True)  # Field name made lowercase.
    copies = models.IntegerField(db_column='Copies')  # Field name made lowercase.
    activecopies = models.IntegerField(db_column='ActiveCopies')  # Field name made lowercase.
    cover_image = models.ImageField(db_column='CoverImage', blank = True, null =True, default="covers/book_default.png", upload_to="covers/")

    class Meta:
        managed = False
        db_table = 'Book'
     
    
    def __str__(self):
        return self.title


class Bookcopy(models.Model):
    itemid = models.ForeignKey('Item', models.DO_NOTHING, db_column='ItemID', primary_key=True)  # Field name made lowercase.
    isbn = models.ForeignKey(Book, models.DO_NOTHING, db_column='ISBN', blank=True, null=True)  # Field name made lowercase.
    checkedout = models.IntegerField(db_column='CheckedOut')  # Field name made lowercase.
    isheld = models.IntegerField(db_column='IsHeld')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'BookCopy'


class Checkin(models.Model):
    itemid = models.ForeignKey('Item', models.DO_NOTHING, db_column='ItemID')  # Field name made lowercase.
    userid = models.ForeignKey('UsersCustomuser', models.DO_NOTHING, db_column='userID')  # Field name made lowercase.
    datecheckedin = models.DateField(db_column='DateCheckedIn')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'CheckIn'


class Checkout(models.Model):
    transactionid = models.AutoField(db_column='TransactionID', primary_key=True)  # Field name made lowercase.
    userid = models.ForeignKey('UsersCustomuser', models.DO_NOTHING, db_column='userID')  # Field name made lowercase.
    itemid = models.ForeignKey('Item', models.DO_NOTHING, db_column='itemID')  # Field name made lowercase.
    checkoutdate = models.DateField(db_column='CheckOutDate')  # Field name made lowercase.
    duedate = models.DateField(db_column='DueDate')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'CheckOut'


class Copiesborrowed(models.Model):
    userid = models.ForeignKey('UsersCustomuser', models.DO_NOTHING, db_column='userID', primary_key=True)  # Field name made lowercase.
    copies_borrowed = models.IntegerField(db_column='Copies_Borrowed')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'CopiesBorrowed'
        
class Currentcheckedout(models.Model):
    userid = models.ForeignKey('UsersCustomuser', models.DO_NOTHING, db_column='userID')  # Field name made lowercase.
    itemid = models.ForeignKey('Item', models.DO_NOTHING, db_column='itemID', primary_key=True)  # Field name made lowercase.
    checkoutdate = models.DateField(db_column='CheckOutDate')  # Field name made lowercase.
    duedate = models.DateField(db_column='DueDate')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'CurrentCheckedOut'


class Currentholds(models.Model):
    itemid = models.ForeignKey('Item', models.DO_NOTHING, db_column='itemID', primary_key=True)  # Field name made lowercase.
    userid = models.ForeignKey('UsersCustomuser', models.DO_NOTHING, db_column='userID')  # Field name made lowercase.
    holddate = models.DateField(db_column='HoldDate')  # Field name made lowercase.
    helduntildate = models.DateField(db_column='HeldUntilDate')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'CurrentHolds'


class Finetransactions(models.Model):
    userid = models.ForeignKey('UsersCustomuser', models.DO_NOTHING, db_column='userID')  # Field name made lowercase.
    transtype = models.CharField(db_column='TransType', max_length=7)  # Field name made lowercase.
    transactiondate = models.DateField(db_column='TransactionDate')  # Field name made lowercase.
    amount = models.DecimalField(db_column='Amount', max_digits=4, decimal_places=2)  # Field name made lowercase.
    checkoutid = models.ForeignKey(Checkout, models.DO_NOTHING, db_column='CheckOutID', blank=True, null=True)  # Field name made lowercase.
    transactionid = models.AutoField(db_column='TransactionID', primary_key=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'FineTransactions'


class Finesrecord(models.Model):
    userid = models.ForeignKey('UsersCustomuser', models.DO_NOTHING, db_column='userID', primary_key=True)  # Field name made lowercase.
    amount = models.DecimalField(db_column='Amount', max_digits=4, decimal_places=2, blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'FinesRecord'


class Holds(models.Model):
    itemid = models.ForeignKey('Item', models.DO_NOTHING, db_column='ItemID', blank=True, null=True)  # Field name made lowercase.
    userid = models.ForeignKey('UsersCustomuser', models.DO_NOTHING, db_column='userID', blank=True, null=True)  # Field name made lowercase.
    holddate = models.DateField(db_column='HoldDate', blank=True, null=True, auto_now_add=True)  # Field name made lowercase.
    helduntildate = models.DateField(db_column='HeldUntilDate', blank=True, null=True)  # Field name made lowercase.
    heldtransactionid = models.AutoField(db_column='HeldTransactionID', primary_key=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Holds'


class Item(models.Model):
    itemid = models.IntegerField(db_column='itemID', primary_key=True)  # Field name made lowercase.
    itemtype = models.CharField(db_column='ItemType', max_length=5)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Item'


class Logincredentials(models.Model):
    userid = models.ForeignKey('UsersCustomuser', models.DO_NOTHING, db_column='userID', unique=True)  # Field name made lowercase.
    user_password = models.CharField(max_length=32)

    class Meta:
        managed = False
        db_table = 'LoginCredentials'


class Movie(models.Model):
    isan = models.CharField(db_column='ISAN', primary_key=True, max_length=24)  # Field name made lowercase.
    title = models.CharField(db_column='Title', max_length=30, blank=True, null=True)  # Field name made lowercase.
    director = models.CharField(db_column='Director', max_length=25, blank=True, null=True)  # Field name made lowercase.
    rating = models.CharField(db_column='Rating', max_length=5, blank=True, null=True)  # Field name made lowercase.
    genre = models.CharField(db_column='Genre', max_length=15, blank=True, null=True)  # Field name made lowercase.
    copies = models.IntegerField(db_column='Copies')  # Field name made lowercase.
    activecopies = models.IntegerField(db_column='ActiveCopies')  # Field name made lowercase.
    cover_image = models.ImageField(db_column='CoverImage', blank = True, default="covers/movie_default.png", null =True, upload_to="covers/")

    class Meta:
        managed = False
        db_table = 'Movie'
    def __str__(self):
        return self.title

class Moviecopy(models.Model):
    itemid = models.ForeignKey(Item, models.DO_NOTHING, db_column='ItemID', primary_key=True)  # Field name made lowercase.
    isan = models.ForeignKey(Movie, models.DO_NOTHING, db_column='ISAN', blank=True, null=True)  # Field name made lowercase.
    checkedout = models.IntegerField(db_column='CheckedOut')  # Field name made lowercase.
    isheld = models.IntegerField(db_column='IsHeld')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'MovieCopy'


class Musiccopy(models.Model):
    itemid = models.ForeignKey(Item, models.DO_NOTHING, db_column='ItemID', primary_key=True)  # Field name made lowercase.
    ismn = models.ForeignKey('Sheetmusic', models.DO_NOTHING, db_column='ISMN', blank=True, null=True)  # Field name made lowercase.
    checkedout = models.IntegerField(db_column='CheckedOut')  # Field name made lowercase.
    isheld = models.IntegerField(db_column='IsHeld')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'MusicCopy'


class Roles(models.Model):
    rolename = models.CharField(db_column='RoleName', primary_key=True, max_length=5)  # Field name made lowercase.
    role_description = models.CharField(db_column='Role Description', max_length=15)  # Field name made lowercase. Field renamed to remove unsuitable characters.

    class Meta:
        managed = False
        db_table = 'Roles'


class Sheetmusic(models.Model):
    ismn = models.CharField(db_column='ISMN', primary_key=True, max_length=13)  # Field name made lowercase.
    title = models.CharField(db_column='Title', max_length=30, blank=True, null=True)  # Field name made lowercase.
    composer = models.CharField(db_column='Composer', max_length=25, blank=True, null=True)  # Field name made lowercase.
    genre = models.CharField(db_column='Genre', max_length=15, blank=True, null=True)  # Field name made lowercase.
    copies = models.IntegerField(db_column='Copies')  # Field name made lowercase.
    activecopies = models.IntegerField(db_column='ActiveCopies')  # Field name made lowercase.
    cover_image = models.ImageField(db_column='CoverImage', blank = True, null =True, default="covers/music_default.png", upload_to="covers/")

    class Meta:
        managed = False
        db_table = 'SheetMusic'
       
    def __str__(self):
        return self.title


class User(models.Model):
    iduser = models.AutoField(db_column='idUser', primary_key=True)  # Field name made lowercase.
    firstname = models.CharField(db_column='FirstName', max_length=45)  # Field name made lowercase.
    middlein = models.CharField(db_column='MiddleIn', max_length=1, blank=True, null=True)  # Field name made lowercase.
    lastname = models.CharField(db_column='LastName', max_length=45)  # Field name made lowercase.
    role = models.ForeignKey(Roles, models.DO_NOTHING, db_column='Role')  # Field name made lowercase.
    phonenumber = models.CharField(db_column='PhoneNumber', max_length=15, blank=True, null=True)  # Field name made lowercase.
    birthdate = models.DateField(db_column='BirthDate', blank=True, null=True)  # Field name made lowercase.
    email = models.CharField(db_column='Email', max_length=45)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'User'


class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=150)

    class Meta:
        managed = False
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    name = models.CharField(max_length=255)
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)


class DjangoAdminLog(models.Model):
    action_time = models.DateTimeField()
    object_id = models.TextField(blank=True, null=True)
    object_repr = models.CharField(max_length=200)
    action_flag = models.PositiveSmallIntegerField()
    change_message = models.TextField()
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey('UsersCustomuser', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'django_admin_log'


class DjangoContentType(models.Model):
    app_label = models.CharField(max_length=100)
    model = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40)
    session_data = models.TextField()
    expire_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_session'


class UsersCustomuser(models.Model):
    password = models.CharField(max_length=128)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.IntegerField()
    username = models.CharField(unique=True, max_length=150)
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=150)
    email = models.CharField(max_length=254)
    is_staff = models.IntegerField()
    is_active = models.IntegerField()
    date_joined = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'users_customuser'


class UsersCustomuserGroups(models.Model):
    customuser = models.ForeignKey(UsersCustomuser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'users_customuser_groups'
        unique_together = (('customuser', 'group'),)


class UsersCustomuserUserPermissions(models.Model):
    customuser = models.ForeignKey(UsersCustomuser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'users_customuser_user_permissions'
        unique_together = (('customuser', 'permission'),)
