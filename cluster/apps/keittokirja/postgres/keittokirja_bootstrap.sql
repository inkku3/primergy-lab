-- Keittokirja PostgreSQL bootstrap
--
-- This is the canonical initial database state for the Keittokirja
-- CloudNativePG cluster. It is intended to run during initial database
-- creation via postInitApplicationSQLRefs.
--
-- Source:
--   Original Firestore export: keittokirja_migration.sql
--   Additional recipes/tags:   keittokirja-26-08-11.pdf
--
-- The original tag data is intentionally not copied. Tags are normalized
-- to the project's Finnish taxonomy below.

-- PostgreSQL migration generated from Firestore export
-- Source: keittokirja-fd7ae7 Firestore project, 'recipes' collection
BEGIN;
SET ROLE keittokirja;
CREATE TABLE recipes (
    id           text PRIMARY KEY,
    title        text NOT NULL,
    ingredients  text,
    instructions text,
    info         text
);

CREATE TABLE recipe_tags (
    recipe_id text NOT NULL REFERENCES recipes(id) ON DELETE CASCADE,
    tag       text NOT NULL,
    PRIMARY KEY (recipe_id, tag)
);

CREATE INDEX recipe_tags_tag_idx ON recipe_tags (tag);

INSERT INTO recipes (id, title, ingredients, instructions, info) VALUES
($q$Pippurikerma-kastike$q$, $q$Pippurikermakastike$q$, $q$2 dl kuohukermaa
1 Fond du chef beef hyytelö kuutio
½ rkl Dijon sinappia
2 rkl kokonaisia mustapippureita
Pieni tilkka Worchestershire kastiketta ja/tai soijaa – voi jättää poiskin
Plöräys brändyä – voi jättää poiskin$q$, $q$Paahda pippureita kannellisessa kattilassa kunnes ne alkavat poksua, ota pois kattilasta ja jauha morttelissa. Paahtamisen sijaan voi käyttää paahtamattomia jauhettuja mustapippureita mutta niiden maku jää paljon heikommaksi.


Laita pippurit ja muut ainekset kattilaan ja lämmitä sekoittaen kunnes kastike kiehahtaa. Tarkista paksuus ja keitä tarvittaessa lisää. Tarkista maku ja lisää limetti/sitruuna mehua jos kastike on liian makea (laktoosittomat kermat voivat aiheuttaa makeutta).$q$, $q$Tämä perus pippurikerma kastike sopii lähes minkä tahansa lihan ja lisukkeen kera aina lihapullista Tournedokseen. Lisukkeina toimivat peruna, pavut, herneet, porkkanat ja muut juurekset sekä riisi, pastat, linssit jne. – menee melkein minkä kanssa vaan.$q$),
($q$ankanrinnat$q$, $q$Paistetut ankanrinnat$q$, $q$Puolikas ankanrinta per ruokailija
Suolaa, pippuria, (fenolin siemeniä, aniksen siemeniä (ei tähtianis))$q$, $q$Laita uuni päälle 180C. Tarkista ettei rintoihin ole jäänyt luun tai ruston palasia. Tee nahkaan ristikkoviillot, n. 1.5-2cm välillä. Mausta pinnat, esim. suola + pippuri tai suola + jauhettu fenkolin siemen ja anis. Laita rinnat kylmällä pannulle nahkapuoli alaspäin, ala lämmittää ja paista kunnes nahka on keski ruskea. Käännä palat ja karamelisoi toinen puoli. Laita rinnat vuokaan, paistolämpömittari paksuimpaan kohtaan ja lämmöksi 48C. Paista kunnes mittari piippa ja ota vetäytymään, jätä mittari paikoilleen. Seuraa mittaria ja kun lämpö lakkaa kohoamasta poista mittari ja tarjoa anakanrinnat esim. yllä olevien linssien ja portviini kastikkeen kera.$q$, NULL),
($q$avokadopasta$q$, $q$Kermainen kana-avocado pasta$q$, $q$300 g pastaa, esim. Capelliniä
n. 250-350g silputtua kanaa, grillatun kanan jämät tms.
2 dl kermaa
1 rkl soijaa
1 rkl Madras curryjauhetta (se keltainen tavallinen)
1 tl valkosipuli jauhetta
1-3 tl Srirachaa (maun mukaan)
4 syöntikypsää avocadoa$q$, $q$Halkaise avocadot, poista kivi ja poista kuorista. Viipaloi ja mausta suolalla + pippurilla.
Sekoita pienessä kattilassa kerma ja mausteet ja kiehauta. Keitä pasta al denteksi hyvin suolatussa
vedessä. Valuta pasta, kaada sekaan kastike ja kana, sekoittele kunnes kastike on imeytynyt. Laita
lautasille röykkiö pastaa ja kanaa ja koristele avocadon viipaleilla.$q$, $q$4+ henkeä$q$),
($q$balmoral-kastike$q$, $q$Balmoral kastike$q$, $q$2 dl kuohukermaa
1 Fond du chef beef hyytelö kuutio
½ rkl Dijon sinappia
2 rkl kokonaisia mustapippureita
100-150g herkkusieniä viipaleina tai silputtuna
2 rkl halpaa blended whiskyä$q$, $q$Tee aineksista perus pippurikermakastike ja sekoita siihen herkkusienet ja whisky. Herkkusienistä irtoaa nestettä kastikkeeseen joten sitä pitää keitellä muutama minuutti kasaan jolloin kastikkeesta myös haihtuu alkoholi joka tuo siihen kitkerää makua.$q$, NULL),
($q$balti-ghost$q$, $q$Lammasta valkosipulin, inkiväärin ja tomaatin kera (Balti Ghost)$q$, $q$700 g luutonta lammasta
5 dl vettä
1 tl suolaa
3 tomaattia
3 valkosipulinkynttä
1 rkl punaista chilipaprikaa
1 tl jauhettua inkivääriä
1 tl kurkumaa
1 rkl paprikajauhetta
1 dl oliiviöljyä
2 rkl tuoretta hienonnettua korianteria
1 vihreä chilipalko koristeluun$q$, $q$Leikkaa lampaanliha suupalan kokoisiksi paloiksi. Hienonna tomaatit. Kuori ja murskaa valkosipulinkynnet.

Laita liha ja kaikki muut mausteet paitsi korianteri ja chilipalko kasariin ja hauduta 20-25 minuttia. Tarkista, ettei liha ole kuivinut liikaa. Tarvittaessa lisää hieman vettä, etteivät mausteet pala.

Sekoita lihan sekaan korianteri ja anna maustua pari minuttia ennen tarjjoilua. Tarjoillaan vihannesten tai linssien kera.$q$, $q$Tämä on 'kuiva' curry.$q$),
($q$bechamel-kastike$q$, $q$Lasagne (bechamel kastike)$q$, $q$1 litra maitoa
1.1 dl jauhoa
2 tl muskottipähkinää
Rypsiöljyä
Suolaa 
Pippuria$q$, $q$Lasagnea varten valmista ensin bolognesekastike.

Laita jauhot kasariin ja lisäile oljyä lämmittäen kunnes pannulla on notkea jauho/rasva seos. Lämmitä kunnes se alkaa kuplia mutta älä ruskista. Lisää pikkuhiljaa maitoa sekoittaen vispilällä. Käytännössä maito kannattaa lisätä 3-4:ssä erässä imeyttäen se joka kerta jauhoihin voimakkaasti sekoittaen kunnes “klompit” ovat liuenneet. Lisää mausteet ja tarkista maku.

Ota 7 kauhallista bechamelia erikseen ja sekoita loppu bechamel ja bolognese keskenään. Ala kasata lasagnea, ensin bechamel/bolognese sekoitus ja sitten levyjä kerroksittin. Viimeisen levykerroksen päälle kaada erikseen otettu bechamel ja ripoittele päällä parmesania. Paista 200 asteisessa uunissa 40-45 minuuttia.$q$, NULL),
($q$bolognese-kastike$q$, $q$Bolognese kastike$q$, $q$400 g naudan jauhelihaa
1 prk tomaatti murskaa

1 sipuli hienona silppuna
1-2 porkkanaa hienoksi raastettuna
1-2 sellerin vartta hienonnettuna
2 valkosipulin kynttä
1 tl korianteri jauhetta
2 tl timjamia
2 tl srirachaa
1 tl MSG:tä
0.5 dl punaviiniä
pari tippaa savuaromia
Öljyä, suolaa, pippuria$q$, $q$Kuullota hienonnettu sipuli öljyssä, lisää porkkana raaste, selleri silppu ja purista valkosipulit sekaan. Paista pari minuuttia ja lisää jauheliha. Murustele jauheliha ja lisää korianteri + sriracha + suola ja pippuri – tarkista maku. Lisää punaviini ja haihduta alkoholi. Lisää tomaattimurska, timjami, MSG ja savuaromi. Hauduttele ja sekoita hetken aikaa, säädä lopuksi maku.$q$, $q$Tätä voi käyttää mm. lasagneen tai pastan seurana$q$),
($q$broccoli-paistos$q$, $q$Parsakaali paistos$q$, $q$n. 400g pakastettua broccolia
n. 100g pekonia, pekonikuutiot toimivat hyvin
1 valkosipulin kynsi viipaloituna
1-3tl chiliflaiksejä maun mukaan
n. 0.5-1dl raastettua kermajuustoa, voi käyttää enemmänkin
tilkka öliiviöljyä paistamiseen$q$, $q$Keitä broccolit pehmeiksi suolavedessä, n. 12 min, valuta hyvin ja pilko hieman pienemmiksi. Paista pekoni ja chili tilkassa öljyä kunnes pekoni on ruskistunut, lisää valkosipuli ja paista hetki kullankeltaiseksi (varo polttamasta). Lisää broccoli ja sekoita. Mausta suolalla ja pippurilla ja raasta sekaan juusto. Kääntele ja paista hetki, juuston voi antaa paistua osin rapeaksi.$q$, NULL),
($q$chalupa$q$, $q$Chalupa$q$, $q$7 dl jauhoja (n. 380g)
1.5 rkl leivinjauhetta
1 tsp suolaa
2 rkl sulatettua voita tai öljyä
3 dl maitoa
öljyä paistamiseen$q$, $q$Sekoita kuiva-ainekset ja voi keskenään, lisää maito ja sekoittele pehmeäksi taikinaksi. Lisää tarvittaessa jauhoa. Siirrä jauhotetulle leikkuulaudalle ja anna levätä 15-20 minuuttia. Litistä kiekoksi ja jaa taikina kahdeksaan osaan. Pyöritä palat palloiksi, litistä ne ja venyttele/painele tosi ohkaisiksi lätyiksi käyttäen jauhoja tarpeen mukaan tarttumisen estämiseksi. Paistele lätyt pannulla öljyssä keskilämmöllä kullankeltaisiksi molemmin puolin, ne kohoavat noin 10mm paksuisiksi tässä vaiheessa.

Tarjoile esim. Maustetun lihan, tai papujen kanssa lisukkeena salaattia, tomaattia ym. sekä kastikkeita + jugurttia.

Chalupat voi paistaessa kääntämisen jälkeen taivuttaa tacon mallisiksi ja paistaa tacon molemmat sivut jos haluaa tehdä taskun johon täytteet voi sovittaa ja sitten tursaista rinnuksille puraistessa. Maastokuvioinen pusero on suositeltava asuste syödessä näitä (esim. Waffen SS Flecktarn punasävytteisenä imee chili tahrat osaksi kuviota).$q$, $q$sisältä pehmeä ja pinnasta rapea lätty joka sopii meksikolaiseen ja intialaiseen ruokaan. 8 leipää - 6-8 henkeä.$q$),
($q$chicken-tikka-masala$q$, $q$Chicken Tikka Masala$q$, $q$1 kg broileria kuutioituna

Marinadi:
250 g 10% rasvaa sisältävää maustamatonta jugurttia
2 valkosipulin kynttä
2 tbsp raastettua inkivääriä tai 2tsp jauhetta
2 tsp jeeraa eli juustokuminaa
1 tsp jauhettua kanelia
1 rkl chilikastiketta (sriracha) tai 2 tsp chilijauhetta
2 tsp jauhettua mustapippuria
1 tsp suolaa

Kastike:
2 purkkia paseerattua tomaattia (n. 900g)
2 valkosipulin kynttä
1/2 rkl chilikastiketta (sriracha) tai 1 tsp chilijauhetta
2 tsp jeeraa eli juustokuminaa
2 tsp jauhettua korianteria (dhana)
2 tsp paprika jauhetta
2 rkl voita tai neutraalia öljyä
2 tsp jauhettua kardemummaa
2 tsp kurkumaa
2 tsp garam masalaa
2 tsp jauhettua mustapippuria
1 tsp suolaa

(korianterin lehtiä)$q$, $q$Sekoita marinadin ainekset keskenään ja sekoita kana marinadiin maustumaan pariksi tunniksi jääkaappiin. Kun kana on marinoitunut aloita kastikkeen teko lämmittämällä öljy/voi kasarissa tai wokki pannussa. Lisää mausteet ja lämmitä kunnes valkosipuli on saanut hieman väriä. Lisää tomaattipasee ja lämmitä kunnes se alkaa kuplia. Tarkista suolan ja chilin määrä, lisää tarvittaessa. Lisää kana marinadeineen kastikkeeseen ja lämmitä kiehuvaksi. Anna kuplia miedolla lämmöllä noin 20 minuuttia.

Ripottele pinnalle silputtuja korianterin lehtiä (voi jättää pois) ja tarjoa riisin, chapatin ja raidan kanssa.$q$, NULL),
($q$chickenwings$q$, $q$Crispy chicken wings$q$, $q$800-900g maustamattomia broilerin siipi paloja (n. 20 kpl)
½ tl suolaa
1 rkl leivinjauhetta$q$, $q$Laita siivet kulhoon , ripottele päälle suola ja leivinjauhe ja sekoita hyvin.

Lämmitä uuni 120C asteeseen ja laita siivet uuniin pellillä jossa leivinpaperi, paista 30 minuuttia
Nosta lämpö 225 asteeseen ja paista 30-40 minuuttia kunnes siivet ovat raoean kullankeltaisia mutta eivät vielä kuivia.

Siirrä siivet kulhoon ja kaada päälle siipikasteiketta ja sekoita.

Tarjoa ranskanperunoiden, porkkana suikaleiden ja dippi kastikkeen kera.$q$, NULL),
($q$chili-con-carne$q$, $q$Chili con Carne$q$, $q$400 g naudanjauhelihaa
1 iso sipuli silputtuna
1 paprika silputtuna
2 valkosipulin kynttä murskattuna
400g tomaattimurskaa
400g purkki valkoisia papuja tomaattikastikkeessa
400 g purkki kidney papuja valutettuna

2 tl juustokuminaa
1 tl korianteria
1 tl neilikkaa
1 tl kanelia
1 tl mustapippuria
1 rkl srirachaa
1 rkl kuivattua oreganoa
pari tippaa savuaromia (ei pakollinen)
1 tl MSG:tä (natriumglutamaatti, ei pakollinen)
1 rkl viinietikkaa
suolaa
öljyä paistamiseen$q$, $q$Lämmitä kaneli ja neilikka öljyssä kunnes ne alkavat kuplia, lisää sipuli ja kuullota. 

Lisää jauheliha, suola, pippuri, sriracha sekä valkosipuli. Murenna liha ja paista se ruskeaksi. Lisää  kumina ja korianteri ja paista hetki.

Lisää paprika, hauduta hetki ja lisää tomaattimurska, savuaromi, msg, oregano ja viinietikka – sekoita ja hauduta muutama minuutti. Lisää pavut ja anna hautua hetki. Tarkista maku ja säädä tarpeen mukaan.$q$, $q$Chilin voi tarjota tortillojen tai tacojen kera tai sen voi kääräistä vaikka salaatin lehteen. Myös riisi käy chili con carnen lisukkeeksi ja sitä voi vaikka laittaa sämpylän päälle ja kuorruttaa juustolla uunissa.

Lisukkeeksi sopivat erinomaisesti esimerkiksi:
Tomaatti
Kurkku
Juusto raaste
Jäävuorisalaatti
Sipuli 
Creme fraiche
Tomaatti salsa$q$),
($q$chimichurri$q$, $q$Chimichurri marinadi$q$, $q$1 dl oliiviöljyä
0.7 dl punaviinietikkaa
2 valkosipulin kynttä
2 dl silputtua persiljaa
0.5 dl silputtua korianteria (lehtiä)
¾ tl chiliä
½ tl juustokuminaa
½ tl suolaa
1 nippu silolehtistä persiljaa$q$, $q$Yhdistä$q$, $q$Todellisen chimichurrin koostumuksesta on käyty paljon keskustelua ja voinkin todeta että tämä ei ole aito Argentiinalaisen chimichurrin resepti. Tämä resepti toimii kuitenkin erinomaisesti grillatun naudanlihan ja kanan kanssa joten suosittelen kokeilemaan.$q$),
($q$coleslaw$q$, $q$Coleslaw (kaalisalaatti)$q$, $q$400 gr kaalia
1 porkkana
n. 1,5 dl majoneesia
1 rkl dijon sinappia
(etikassa ja suolassa marinoitua sipulia)
suolaa
pippuria$q$, $q$Suikaloi kaali ja raasta porkkana karkeaksi. Sekoita majoneesi ja sinappi. Laita vihannekset kulhoon ja sekoita majoneesi sekaan. Mausta suolalla ja pippurilla. Porkkanan voi jättää poiskin jos haluaa pitää hiilihydraatti määrän matalan.$q$, $q$Tämä on lisuke jota erityisesti USA:ssa tarjotaan BBQ lihan ja pihvien kera.$q$),
($q$curry-pasta$q$, $q$Currypasta (ihan sama)$q$, $q$1 rkl vihreää currytahnaa
1 tl jauhettua korianteria
400-500 g kanasuikaleita
Puolikas hienonnettu sipuli
1-2 rkl soijaa
1 tl lime mehua
2rkl ketsuppia
2 dl kermaa
1 rkl kalakastiketta
kanaliemikuutio / fondi$q$, $q$Kuumenna currytahna öljyssä, lisää sipuli ja paista hetki, lisää kana ja korianteri ja paista pinnat. Lisää loput aiensosat ja hauduttele kanat kypsäksi. Tarjoa spagetin tai nuudelien kera.$q$, $q$Mitä tänään syötäisiin?  "Ihan sama", ja tämä syntyi.$q$),
($q$eren-tomaattikastike$q$, $q$Tomaattikastike a la Ere$q$, $q$Purkki tomaattimurskaa
Plöräys viinietikkaa
Suola
Sokeri
Pippuri
Sellerisuola
Oregano
Basilika
Muutama tippa srirachaa
Chilirouhe$q$, $q$Yhdistä$q$, NULL),
($q$fenkoligratiini$q$, $q$Fenkoligratiini$q$, $q$1 kg fenkolia
2dl juustokastiketta
1 dl parmesaania tai gryerea$q$, $q$Leikkaa fenkolin varret kuuteen-kahdeksaan osaan, kiehauta, kunnes ovat kypsyneet napakoiksi. Fenkoleiden kiehuessa valmista pari desiä juustokastiketta (resepti löytyy hakemistosta). Lämmitä uuni 200 asteiseksi. Laita fenkolit uunin kestävään vuokaa, kaada päälle juustokastike ja ripottele pinnalle parmesaania tai gryerea. Halutessasi voit silputa fenkolin vihreät osat juustokastikkeen sekaan tai käyttää koristeena valmiin gratiinin päällä. Paista uunissa noin 20 minuuttia tai kunnes juusto pinnalla on kauniisti ruskistunut.$q$, NULL),
($q$grillattu-lohi$q$, $q$Grillattu lohi$q$, $q$1 Lohifile
Litra suolalientä jossa 60g suolaa$q$, $q$Nypi ruodot pois, poista evä ja leikkaa file puoliksi kahteen palaan. Liota filettä tunti suolaliemessä,
laita sitten sous videehen 54C asteeseen tunniksi. Poista nahka vetämällä (paitsi jos suomustit sen),
öljyä kalan pintä kevyesti ja grillaa molemmin puolin pinnat halsterissa.
Suolauksen voi tehdä hieman ylipitkässä sous videe pussissa, kun lohi on suolaantunut avaa pussi,
kaada suolaliemi pois ja vedä pussi vakuumilla uudelleen kiinni. Lohen puolikkaat voi laittaa
päällekkäin pussiin.
Lohi on sitten kypsää kun se tulee ulos pussista ja murenee erittäin helposti. Resepti kaipaa vielä
hiomista.$q$, NULL),
($q$grillimarinadi-kanalle$q$, $q$Grillimarinadi kanalle$q$, $q$1 kg kanaa, esim. reisipaloja
1⁄2 dl rypsi tai oliivi öljyä
1⁄4 dl soijaa
2 valkosipulin kynttä
1 rkl lime mehua
1 rkl ruokosokeria
1⁄2 rkl Dijon sinappia
1⁄2 tlk timjamia
1⁄2 tlk suolaa
1⁄2 tlk mustapippuria
1-2 jalapenoa$q$, $q$Laita ainekset mixeri kulhoon ja purauta mixerillä marinadiksi. Anna sokerin liueta hetki, tarkista
hapokkuus ja lisää tarvittaessa sokeria tai lime mehua. Laita kana minigrip pussiin ja kaada marinadi
päälle. Sekoittele kunnes marinadi on levinnyt kanoihin, sulje pussi ja jätä marinoitumaan tunniksi tai
kahdeksi. Marinadissa ei pahemmin ole suolaa joten kana kannattaa ostaa suolattuna tai liottaa pari
tuntia 6% suolaliemessä ennen marinointia.
Helppo ja nopea metodi on laittaa kana pussiin mausteliemessä (6% suolaliemi + jeera + paprika +
rosmariini) ja sous videehen 1-2 tunniksi. Tämän jälkeen kana pois liemestä ja marinadi pintaan.
Marinadista joka jää kulhon pohjalle saa suurustamalla loistavan kastikkeen.$q$, NULL),
($q$grillioljy$q$, $q$Grilliöljy$q$, $q$1/2dl soijaa
1rkl tomaattipyrettä
Ripaus pippuria
Pari tippaa chiliä ja liquid smokea$q$, $q$Bamixsilla sekaisin
Lisää 3/4dl öljy vatkaten.$q$, NULL),
($q$hapanjuuri-patonki$q$, $q$Ranskalainen hapanjuuri patonki$q$, $q$240 g hapanjuurta, vaihtoehtoisesti sekoita edellisenä iltana levain ja käytä hapanjuuren tilalla
255 g n. 35C vettä
ripaus sokeria
½ pakettia Rajaniemen tuorehiivaa
380 g vehnäjauhoa
40 g kokojyvä vehnäjauhoa
12 g hienoa merisuolaa$q$, $q$Levain, 60g jauhoa + 60g kuivattua hapanjuurta – vaihtoehtoisesti 120g jauhoa, 120g vettä, hyvin pieni määrä hiivaa. Sekoita keskenään ja jätä kannen tai kelmun alla yöksi lämpimään. 

Sekoita vesi, sokerin ripaus ja murusteltu hiiva ja jätä heräämään kun sekoitat muut aineet (alkaa hieman kuplia).

Mittaa kulhoon hapanjuuri, jauhot, suola ja lisää herännyt hiiva/vesi seos. Sekoita noin 10m yleiskoneella. Kaavi taikina kannelliseen vuokaan ja jätä kohoamaan 35 minuutiksi.
Taittele taikina, venytä ja taita neljään suuntaan märillä käsillä kaapimella auttaen ja jätä lepäämään jälleen 35 minuutiksi. Toista taiittelu ja lepuuta jälleen 35 minuuttia.

Jaa taikina kolmeksi palloksi jauhottaen ja anna niiden levätä 15 minuuttia liinan alla. Moitoile pallot patongeiksi taitellen patonkivuokaan, jauhoa kannattaa käyttää. Peitä liinalla.
Tässä vaiheessa patongit voidaan laittaa jääkaappiin odottamaan käyttöä tai niiden annetaan kohota heti paistoa varten. Kohoaminen kestää noin 1-1.5 tuntia ja patonkeja kannattaa tarkistaa loppupuolella jotta ne eivät ala lässähtää. Kohoamisen aikan uuni lämmitetään 225 asteeseen.

Kun patongit ovat kohonneet tee niihin viillot ja kastele ne suihkepullolla. Laita 225C uuniin 20 minuutiksi. Tarkista ruskeus ja jos se on sopiva sammuta uuni ja anna patonkien paistua jälkilämmöllä 10 minuuttia. Ota patongit liinan alle jäähtymään, ne ovat valmiita syötäviksi noin 20-30m lepäämisen jälkeen.

Aikataulutus: 10+35+35+35+15+ (130) 90+20+10+20= 4.5 tuntia + veivaukset → Sekoita hiiva + vesi ja veivaa taikina n. 5 tuntia ennenkuin tarvit patongit.$q$, $q$kolme patonkia$q$),
($q$juustokastike$q$, $q$Juustokastike$q$, $q$1.5 dl kermaa
1 tl Dijonsinappia
1 dl kermajuustoa
pannun galseerausnestettä tai 1 rkl fondia
suolaa
pippuria
ripaus cayennepippruia$q$, $q$Kaada kattilaan kerma, teelusikallinen Dijon-sinappia, teelusikallinen fondia tai n. ½ dl paistinpannun glaseerausnestettä. Kuutio noin 1dl juustoa pieniksi paloiksi tai raasta se. Kiehauta nestettä kunnes sinappi on liuennut ja lisää juustokuutiot. Kiehuta kunnes juusto on sulanut ja paksuus on kastikkeelle sopiva. Mausta suolalla ja pippurilla. Ripaus chiliä tai cayenne pippuria antaa mukavasti lisäpotkua jos tuntuu siltä että kastike sitä kaipaa. 

Juustolajeja vaihtelemalla kastikkeeseen saa eri vivahteita, esim. Cheddar ja gruyere ovat kokeilemisen arvoisia.$q$, NULL),
($q$kana-avokado-salaatti$q$, $q$Kana avocado salaatti$q$, $q$Grillattua kanaa kuutioina
Rucolaa tai jäävuorisalaattia
Kirsikka tomaatteja
Kurkkua
Avocadoa viipaleina, suolaa ja pippuria päälle

Salaattikastike kanasalaattiin
1.5 rkl punaviinietikkaa tai balsamiviinietikkaa
1.5 rkl lime mehua
1 rkl dijon sinappia
1 rkl juoksevaa hunajaa
1 tl valkosipuli jauhetta
1 tl suolaa
1 tl jauhettua mustapippuria
noin 1 dl oliiviöljyä$q$, $q$Kaada kaikki aineet kulhoon lukuunottamatta oliiviöljyä, sekoita vispilällä kunnes kaikki on nestettä,
jatka sekoittamista ja kaada oliiviöljy sekaan pienenä norona$q$, NULL),
($q$kana-espanjalaisittain$q$, $q$Mausteinen kana espanjalaisittain$q$, $q$6 luutonta broilerin rintaa
1 limetin mehu
2 rkl oliiviöljyä
6 tl sinappijauhetta
vastarouhittua mustapippuria
2 tl paprikajauhetta
4 kaltattua tomaattia
2 shalottisipulia
1 valkosipulin kynsi
puolikas chilipalko pilkottuna (siemenet poistettuna halutessa miedomman version)
1 rkl viinietikkaa
suolaa
2 rkl tuoretta hienonnettua korianteria
kokonaisia korianterin lehtiä koristeluun$q$, $q$Tee marinadi limemehusta, öljystä, pippurista, sinappijauheesta ja paprikajauheesta. Kaasa se kananrintojen päälle ja anna maustua vähintään tunnin, välillä käännellen.

Kalttaa tomaatit (tai käytä valmista murskaa).

Laita tehosekoittimeen tomaatit, shalotit, valkosipuli, chili, viinietikka ja suola, jauha tasaiseksi ja lisää lopuksi korianteri käsin sekoittamalla.

Laita kanat uunin kestävään vuokaan ja paista 7-10 minuuttia riippuen siitä miten lähellä lämmönlähdettä kanat ovat. Valele välillä marinadilla. Kääännä ja paista toinen puoli samoin. Sirottele hieman suolaa lopuksi.

Laita kanat tarjoilulautaselle, yksi kullekin, koristele korianterin lehdillä tai rouheella, laita viereen lusikallinen tomaattirelissiä.$q$, $q$Chili, korianteri ja punaiset tomaatit tuovat lämpimän tuulahduksen espanjalaisia makuja mausteiseen kanaan.$q$),
($q$kana-vindaloo$q$, $q$Chicken vindaloo$q$, $q$1 kg kanaa, suikaleita, fileitä, reisipaloja – kaikki toimii
1 purkki tomaatti murskaa
400g sipulia
2 kanaliemikuutiota
2 tl kanelia
2 tl neilikkaa
1 rkl kokonaisia juustokuminan siemeniä
1 rkl garam masalaa
2 rkl inkivääriä
6 valkosipulin kynttä
2 tl tai maun mukaan chiliä, flakesit toimii kivasti mutta kaikkea voi kokeilla
1 rkl tamarindi tahnaa
2 rkl punaviinietikkaa
n. 1 rkl ruokosokeria
3 rkl vehnäjauhoa
suolaa$q$, $q$Laita kana kulhoon, kuumenna pannulla kuminan siemeniä ja garam masalaa kunnes ne alkavat hieman savuta, kaada kanana sekaan. Lisää raastettu inkivääri ja puristettu valkosipuli. Kaava sekaan tamarindi, chilit ja viinietikka ja sekoita huolellisesti. Jätä tunniksi kylmään maustumaan, jääkaapissa kansi päällä.

Aja tomaatimurska pyreeksi sauvasekoittimella. Silppua sipulit. Keitä 0.5 litraa kanalientä kuutioista. Laita pannulle öljyä ja lisää kaneli ja neilikka. Kuumenna hetki ja lisää sipuli. Paista sekoittaen kunnes sipuli on pehmennyt. Lisää kanat ja paistele kunnes pinnat ovat saaneet väriä. Lisää jauho ja sekoitakunnes se ei enää ole valkoista. Lisää kanaliemi ja tomaatti pyree ja sekoita hyvin. Hauduta miedolla lämmöllä kannen alla noin 20 min sekoittaen aina välillä. Poista kansi ja lisää lämpöä, kiehuta  välillä sekoittaen kunnes curry on paksuuntunut ja sipulit ovat hajonneet – lisää vettä tarvittaessa. Lisää ruokosokeria taittamaan hapokkuus ja suolaa tuomaan pieni piikki makuun.
Tarjoa riisin, daalin, raidan ja chapatin kera.$q$, NULL),
($q$kanakeitto$q$, $q$Kanakeitto$q$, $q$2 isoa sipulia
4 porkkanaa
kypsennettyä kanaa pieninä paloina
kanalientä
500 g herneitä
curryjauhetta
kermaa$q$, $q$Kiehauta kanaliemi, lisää hienonnettu sipuli sekä viipaloitu porkkana. Anna kiehua 30 minuuttia. Lisää kana, mausta currylla ja kermalla, lisää herneet ja kiehauta.$q$, $q$Lisää ohraa, riisiä tai vastaavaa tuhdimpaa keittoa varten$q$),
($q$kantarelli-keitto$q$, $q$Kantarelli keitto$q$, $q$200 g kanttarelleja
1 pieni keltasipuli
nokare voita paistamiseen
0.5 l liha- tai kanalientä
1 dl kermaa
suolaa 
pippuria$q$, $q$Sulata nokare voita pannulla. Freesaa sipuli ja hienoksi silputut sienet. Säästä muutama pienempi sieni koristeeksi keiton päälle. Paista kunnes sienistä irronnut neste on lähes kokonaan haihtunut. Lisää lihalientä ensin pari desiä, siirrä tehosekoittimeen ja soseuta juoksevaksi tahnaksi. Siirrä takaisin pannulle / kattilaan, lisää kerma ja loput lihaliemestä siten, että saat keitosta haluamasi paksuisen. 

Tarvittaessa lihaliemen voi korvata kokonaan kermalla, jos haluaa keitosta kermaisemman.$q$, NULL),
($q$keitetyt-naudan-posket$q$, $q$Keitetyt naudan posket$q$, $q$1 kg naudan poskea
1 iso keltasipuli
1 iso porkkana
selleriä (juuri- tai varsi)
puolikas halkaistu valkosipuli
laakerinlehti
mustapippuria
timjami
suola$q$, $q$Keitä naudan posket suolalla maustetussa runsaassa vedessä sipulin ja porkkanan kera, kunnes liha on haarukalla kokeiltuna hajoavan pehmeää.

Tarjoile juuriselleripyreen ja majoneesin kera.$q$, NULL),
($q$kermainen-jauhelihapasta$q$, $q$Kermainen jauhelihapasta$q$, $q$350g bavettea
400g naudan jauhelihaa
1 sipuli
1 valkosipulin kynsi
2 dl kermaa
1 tl MSG
1 rkl timjamia
1 fond du chef nauta tai fondia
1-2 tl sellerisuolaa
2-4 rkl heinzia
2 tl pippuria
1-2 rkl srirachaa
1-2 tl korianterijauhetta
1 rkl Maggi aromea$q$, NULL, NULL),
($q$kermakastike-thoughts$q$, $q$Pieni tutkielma kermakastikkeista$q$, NULL, $q$Ranskalainen keittiö on tunnettu kastikkeistaan ja vaikka kastikkeista puhuttaessa tulee usein mieleen punaviini pohjaiset pihvin lisukkeet on meillä myös hieman vaatimattomammista lähtökohdista ponnistava kermakastikkeiden perhe. Kermakastike ei tarkoita maidosta suurustamalla tehtyä Bechamel tyyppistä kastiketta vaan ihka oikeasta kermasta kevyesti kokoon kiehautettua kastiketta joka on maustettu kulloisenkiin tarkoitukseen sopivaksi. Kermakastike on myös helposti muokattavissa ylelliseksi versioksi juustokastikkeesta.

Keskityn tässä kirjoitelmassa paistettujen liharuokien kanssa tarjottaviin ns. maustetumpiin kermakastikkeisiin ja unohdan keitettyjen lihojen versiot. Käyttämäni kermakastikkeet rakentuvat kaikki samalle pohjalle, kuohu/vispi kermaa ja lihalientä jotka kiehautetaan haluttujen mausteiden kera. Kiireisenä nykykokkina skippaamme lihaliemien redusoinnin ja oikeaisemme käyttämällä lihaliemi (tai kanaliemi) kuutioita, fondia tai mieluiten Fond du chef hyytelöitä. Näistä itse suosin Knorrin tuotteita mutta valitettavasti Knorr lopetti fondiensa myynnin tuodessaan hyytelöpakkaukset markkinoille joten fondina käytän nykyään Touch of taste tuotteita. Fondi on hyvä vaihtoehto silloin kun tehdään pienempiä määriä kastikkeita tai halutaan hienosäätää makua joten sitä on syytä pitää kaapissa kuutioiden/hyytelöiden ohella.

Aloitamme helpolla pippurikerma kastikkeella:

2 dl kuohukermaa
1 Fond du chef beef hyytelö kuutio
½ rkl Dijon sinappia
2 rkl kokonaisia mustapippureita
Pieni tilkka Worchestershire kastiketta ja/tai soijaa – voi jättää poiskin
Plöräys brändyä – voi jättää poiskin

Paahda pippureita kannellisessa kattilassa kunnes ne alkavat poksua, ota pois kattilasta ja jauha morttelissa. Paahtamisen sijaan voi käyttää paahtamattomia jauhettuja mustapippureita mutta niiden maku jää paljon heikommaksi.

Laita pippurit ja muut ainekset kattilaan ja lämmitä sekoittaen kunnes kastike kiehahtaa. Tarkista paksuus ja keitä tarvittaessa lisää. Tarkista maku ja lisää limetti/sitruuna mehua jos kastike on liian makea (laktoosittomat kermat voivat aiheuttaa makeutta).

Tämä perus pippurikerma kastike sopii lähes minkä tahansa lihan ja lisukkeen kera aina lihapullista Tournedokseen. Lisukkeina toimivat peruna, pavut, herneet, porkkanat ja muut juurekset sekä riisi, pastat, linssit jne. – menee melkein minkä kanssa vaan.

Kermakastikkeet tarjoavat myös paljon muita mahdollisuuksia hieman erilaisella maustamisella, alla pari hyvää variaatiota.

Chili kermakastike

2dl kuohukermaa
1 Fond du chef beef hyytelö kuutio
1 rkl Sriracha kastiketta – tai maun mukaan
1 rkl hienoksi kuutioituja jalapeno sliceja – tai maun mukaan

Laita ainekset kattilaan ja lämmitä sekoittaen kunnes kastike on kiehahtanut ja on sopivan paksuista. Erinomaista esim. pastan, riisin tai linssien kanssa. Toimii esim. lehtipihvin, entrecoteen ja kananrintojen lisukkeena.

Tex mex kermakastike

2 dl kuohukermaa
1 Fond du chef chicken hyytelö kuutio
½ rkl Dijon sinappia
1 tl juustokuminaa
1 tl jauhettua korianteria
1 rkl Srirachaa tai maun mukaan

Laita ainekset kattilaan ja lämmitä sekoittaen kunnes kastike on kiehahtanut ja on sopivan paksuista. 

Balmoral kastike

2 dl kuohukermaa
1 Fond du chef beef hyytelö kuutio
½ rkl Dijon sinappia
2 rkl kokonaisia mustapippureita
100-150g herkkusieniä viipaleina tai silputtuna
2 rkl halpaa blended whiskyä

Tee aineksista perus pippurikermakastike ja sekoita siihen herkkusienet ja whisky. Herkkusienistä irtoaa nestettä kastikkeeseen joten sitä pitää keitellä muutama minuutti kasaan jolloin kastikkeesta myös haihtuu alkoholi joka tuo siihen kitkerää makua.

Eri variaatioita tuosta maustetusta kermakastikkeesta voi keksiä vaikka kuinka paljon vaihtelemalla mausteita ja mauste kastikkeita. Seuraava steppi ylöspäin on muokata kermakastike ylelliseksi versioksi juustokastikkeesta. Juustokastiketta valmistettaessa on syytä huomioida pari seikkaa. Ensinnäkin juustoa ei saa kiehuttaa koska se alkaa separoitua kastikkeesta muodostaen klomppeja ja säikeitä. Juusto lisätään kastikkeeseen lopuksi ja pyritään sekoittamaan siihen ilman lämmitystä noin 60C lämpötilassa jolloin saadaan aikaan sileä juustoinen kastike. Toinen huomioitava seikka on käytetty juusto, kaikki juustot eivät sovellu kastikkeisiin. Itse teen juustokastikkeet käyttäen rasvaista kermajuustoa raasteena, unohda terveellisyys tässä kohtaa ja vältä kaikkia kevyt tuotteita jotka on saatu kiinteään muotoon eri lisäaineilla.

Mikä tahansa ylläolevista resepteistä voidaan muokata juustokastikkeeksi jättämällä kastike normaalia juoksevammaksi eli joko lopettamalla lämmitys ennen kiehautusta tai pitämällä kiehautusvaihe hyvin lyhyenä, tämä riippuu paljolti käyttämäsi kerman rasvaprosentista. Kastike otetaan pois lämmöltä ja siihen sekoitetaan noin 1 dl raastettua kermajuustoa. Sekoittamista jatketaan kunnes kastike on sileää, mikäli kastike jäähtyy liikaa ja juusto ei liukene pitää kastiketta lämmittää lisää varovasti.

Juustokastike toimii eri ruokien lisukkeena samoin kuin kermakastikkeetkin ja bonuksena päälle se toimii erinomaisesti gratinointiin. Tyypillisesti käytän gratiineihin perus pippurikermakastike reseptiä jonka muokkaan juustokastikkeeksi. Tämä kastike valutetaan/sekoitetaan gratinoitaviin lisukkeisiin, esim. broccoliin tai pastaan jotka sitten gratinoidaan vuoassa uunissa.

Kannustan kokeilemaan kermakastikkeita, nämä reseptit valmistuvat noin viidessä minuutissa vasemmalla kädellä samalla kun vaikkapa paista pihvit.$q$, NULL),
($q$kotitekoinen-jaatelo$q$, $q$Helppo jäätelö$q$, $q$4 dl kermaa
1 purkki makeutettua kondensoitua maitoa (karamelisoitu versio on erittäin hyvä) vajaa 400 g
2-4 tl vanilija sokeria
100-200 g murskattuja domino keksejä tai murskattua salmiakkia tai suklaata tai pekonia tai ...$q$, $q$Vispaa kerma paksuksi vaahdoksi vanilja sokerin kanssa. Sekoita siihen kondensoitu maito ja
murskatut keksit tai mitä ikinä haluatkin käyttää jäden maustamiseen. Laita vuokaan, folio tai kansi
päälle ja pakkaseen yön yli.$q$, NULL),
($q$kraavilohi$q$, $q$Kraavilohi$q$, $q$N. kilo lohifilettä, ruodot poistettuna mutta nahalla
100g suolaa
10g sokeria
Tilliä, kuivattua tai tuoretta$q$, $q$Sekoita suola, sokeri ja tilli. Leikkaa lohifile kahtia poikittain. Ota alumiinifoliota lautaselle ja ripottele
siihen neljännes suolaseoksesta, puolikas lohi päälle nahka alaspäin, puolet suolasta lohen päälle ja
toinen lohisiivu siihen päälle nahka ylöspäin. Loppu suola viimeisen lohen päälle, wräpätään folioon
paketiksi ja kahdeksi päiväksi jääkaappiin.$q$, $q$Porilaiseen tapaan$q$),
($q$kreikkalainen-salaatti$q$, $q$Kreikkalainen salaatti + kastike$q$, $q$Jäävuorisalaattia
Kirsikkatomaatteja
Kurkkua
Paprikaa
Sipulia
Fetaa

salaattikastike

3 rkl valkoviinietikkaa
1 rkl dijon sinappia
1 rkl juoksevaa hunajaa
1 tl valkosipuli jauhetta
1 tl suolaa
1 tl jauhettua mustapippuria
1 tl kuivattua oreganoa
noin 1 dl oliiviöljyä$q$, $q$Kaada kaikki aineet kulhoon lukuunottamatta oliiviöljyä, sekoita vispilällä kunnes kaikki on nestettä, jatka sekoittamista ja kaada oliiviöljy sekaan pienenä norona$q$, NULL),
($q$kurkuma-kanapasta$q$, $q$Kurkuma-kanapasta$q$, $q$400g pastaa
300g kanafilettä
2dl kermaa
kasvislientä
herkkusieniä
kurkumaa
sitruunamehua
soijakastiketta
valkosipulia
jauhoja suurustukseen$q$, $q$Laita pasta kiehumaan. Mausta kana suolalla ja kurkumalla ja paista melkein kypsäksi öljyssä. Lisää herkkusienet pieninä paloina joukkoon. Lisää valkosipuli sekaan, varmista ettei pala!

Yhdistä jauhot ja oivariini, lisää kasvislientä. Lopuksi mausta sitruunamehulla ja soijalla. Yhdistä kastike ja pasta.$q$, NULL),
($q$laskisoosi$q$, $q$Fläski soosi$q$, $q$Rasvaista sian kylki siivua, n. 500g
1 sipuli
Vehnäjauhoa 1 dl
Suolaa 
Pippuria
Vettä, n. 1 litra kiehautettuna
Tarvittaessa lisää rasvaa, voita tai rypsi öljyä$q$, $q$Silppua sipuli, hienompi on parempi mutta krouvikin toimii ja krouvi on perinteisempää.
Laita kylkisiivut kylmälle pannulle ja lämpö täysille, näin rasva irtoaa paremmin. Mausta siivut raa-alta puolelta suolla ja pippurilla. Ruskista siivut ja käännä, ei mausteita toiselle puolelle. Kun toinenkin puoli on ruskistunut ota siivut kattilaan. Paista tarvittaessa toinen satsi siivuja. Lisää vehnäjauho pannulla olevaan rasvaan ja sekoita, jauhoista pitäisi tulla valuva seos, jos näin ei ole lisää rasvaa. Ruskista jauhoja ankarasti sekoittaen kunnes ne ovat piparkakun väriset tai hieman tummemmat, varo polttamasta niitä. Kun oikea väri on saavutettu lisää sipuli silppu ja sekoita kunnes sipuli on hieman ruskistunut. Sipuli laskee rasva/jauho seoksen lämpötilaa jolloin ruskistuminen pääosin lakkaa, ole kuitenkin tarkkana. Lisää reilu puolet kuumasta vedestä pannulle ja sekoita kiivaasti jotta jauho ei jää klompeiksi. Lisää vettä tarpeen mukaan kunnes kastike on halutun paksuista, Fammu tekee paksua kastiketta mutta Kylli teki ohutta joten makuasia ja kannattaa kokeilla. Mausta lopuksi kastike suolalla ja pippurilla ja kaada kylkisiivujen päälle tai laita kylkisiivut pannulle kastikkeeseen.

Tarjotaan kiinteän perunan (Siikli, Annabelle) tai jauhoisista perunoista tehdyn muusin kanssa. Perunat pitää muussata. Ei rehuja, olut ruokajuomaksi. Tällä ruualla saatiin aikanaan uusi itsenäinen Suomi nousuun.$q$, $q$Tämä varsin aliarvostettu, uskomattoman yksinkertainen tosi muinainen Suomalainen perinneruoka ansaitsee ehdottomasti paikan tässä keittokirjassa. Tämä resepti on suoraan Fammulta ja on itse asiassa sama jota käytetään vuorineuvosten fläskisoosi klubissa.$q$),
($q$lehtipihvi$q$, $q$Lehtipihvi naudan tai sian lihasta$q$, $q$Palat: Naudan sisäpaisti tai paahtopaisti, sian ulkofile tai kasler

Knorrin lihamaustetta
Voita paistamiseen$q$, $q$Leikkaa lihasta n. sentin paksuisia siivuja ja nuiji ne 2-3 kertaan puisella leikkuu laudalla n. 3mm paksuiksi pihveiksi. Mausta toinen puoli kunnolla lihamausteella ja paista ruskistuneessa voissa ensin maustettu puoli alaspäin. Naudanliha paistoaika 30 sekuntia per puoli, sianlihan minuutti per puoli.

Toimii hyvin bearnaise kastikkeen tai pippurikerma kastikkeen kanssa. Lisukkeina esim. ranut, vihreät pavut, porkkanat, pasta etc.$q$, NULL),
($q$lihapullat$q$, $q$Fammun lihapullat (pulla+kastike+muusi)$q$, $q$Lihapullat:
400g naudan jauhelihaa
1 sipuli hienoksi silputtuna
Fondia
Korppujauhoa
Kermaa
(suolaa)
Pippuria

Kastike:
Lihapullien paistoliemi
Fondia
Kermaa
Soijaa
Worcestershire kastiketta
(suolaa)
Pippuria
Maissijauhoa suurustukseen

Muusi:
Rosamundaa/Annabellea
Voita
Maitoa
Sipuli silputtuna
Suolaa$q$, $q$Pyöräytä pullat. Tee kastike. Muussaa muusi.$q$, NULL),
($q$lohikeitto$q$, $q$Lohikeitto (soppa)$q$, $q$1 lohen pää, ruodot ja vatsa palat + pyrstön pää. (tai 300-500g pala lohta)
1 kg kiinteää perunaa (Annabelle, Siikli) pieninä kuutioina
500g porkkanaa pieninä kuutioina
1 kelta sipuli tai 1 purjo silputtuna
Suolaa
Maustepippuria (n. 10 kokonaista)
Laakerin lehti
Nokare voita
Tilkka sitruuna tai lime mehua tarvittaessa$q$, $q$Laita lohenpalat kattilaan, peitä vedellä ja lisää suolaa n. 6-8g / litra. Kiehauta n. 10 minuuttia riippuen lohen koosta. Siilaa lohi pois liemestä ja ota liemi talteen. Lisää liemeen loput ainekset voita ja sitruunaa lukuunottamatta, lisää tarvittaessa vettä ja suolaa (kts. yllä) ja keitä n. 30 minuuttia kunnes perunat ja porkkanat ovat kypsiä. Sopan kiehuessa irrottele lohen liha ruodoista ja nahasta ja palastele haluamaasi kokoon. Noin 5 minuuttia ennenkuin soppa on valmista lisää lohi siihen. Lisää lopuksi voi (määrä riippuu lohen rasvaisuudesta, pinnalla pitää kellua kohtuullisesti rasvaa) ja korjaa makua tarpeen mukaan suolalla sekä sitruuna tai lime mehulla. Tarjoile varrasleivän tai hapanleivän kanssa.$q$, $q$lohena käytä (Salmo Salar, ei mitään v***n kirjolohta (Oncorhynchus mykiss) jollet saa sitä suoraan ulkomeri altaasta)$q$),
($q$maa-artisokka-keitto$q$, $q$Maa-artisokkakeitto$q$, $q$500 g kuorittuja maa-artisokkia paloina
1-2 dl ruokakermaa
suolaa
pippuria
limemehua
jauhettuja korianterin siemeniä
ripaus cayennepippuria$q$, $q$Keitä maa-artisokat pehmeiksi miedosti sitruunalla maustetussa vedessä. Pyreytä tehosekoittimessa tasaiseksi. Mausta pippurilla ja tarvittaessa suolalla sekä korianterilla että varovaisella ripauksella cayennea. Tarjoile lämpimänä.$q$, NULL),
($q$mansikkavaahto$q$, $q$Mansikkavaahto$q$, $q$500 g tuoreita mansikoita 
5 dl kuohukermaa
1 tl vaniljauutetta
ripaus minttua
1 limen raastettu kuori$q$, $q$Vaahdota kerma sekä vaniljauute, lisää lopussa hieman minttua sekä pestyn limen raastettu kuori. 
Tarjoile tuoreiden mansikoiden kera.

Voit myös hienontaa osan mansikoista etukäteen tehosekoittimella ja lisätä sen lopuksi kermavaahtoon. Koristele kokonaisin mansikoin.

Vaahdon voi myös jäädyttää ja tarjoilla sorbetin tapaan palloina.

Vaihtelua vaahtoon saat kokeilemalla erilaisia marjoja, mustikoita, vadelmia tai erilaisia hedelmiä, ei säilykkeitä, sillä ne sisältävät yllättävät määrät sokeria.$q$, NULL),
($q$mexican-rice$q$, $q$Meksikolainen papuriisi$q$, $q$220g riisiä, esim. Jasmiini
1 sipuli silputtuna
1 paprika siputtuna, vihreä on hyvä, voi myös vaihtaa mietoon chiliin
1 tsp juustokuminaa (jeera)
1 tsp korianterijauhetta
1-2 tsp srirachaa
500 ml kana- tai lihalientä
1 tölkki tomaattimurskaa
1 tölkki kidney papuja valutettuna
suolaa tarpeen mukaan
persiljaa tai korianteria koristeluun$q$, $q$Kuullota riisi öljyssä pannulla kunnes pinta muuttuu läpinäkymättömäksi
Lisää sipuli, paprika ja mausteet ja paista pari minuuttia
Lisää pavut, tomaatit ja lihaliemi ja hauduta n. .45 minuuttia kunnes suurin osa nesteestä on imeytynyt
Pöyhi riisi kuohkeaksi, lisää tarvittaessa suolaa ja koristele$q$, NULL),
($q$munakokkeli$q$, $q$Munakokkeli$q$, $q$5 kananmunaa
5rkl ruokakermaa
suolaa
pippuria
ruohosipulia
1 rkl limemehua$q$, $q$Vatkaa munat ja kerama kulhossa kuohkeaksi vaahdoksi, lisää mausteet ja limettimehu. Kaada seos sulan voin sekaan paistinpannulle, hauduta, älä paista. Kääntele varovasti, kunnes rakenne on sopiva, ei liian kiinteä, vaan hieman löysähkö. Tarjoile ruohosipulisilpun kera.$q$, $q$neljälle$q$),
($q$murgh-masala$q$, $q$Murgh Masala$q$, $q$n. 500g suikaloitua kanaa, filettä tai reisipaloja
1 prk tomaattimurskaa
2 valkosipulin kynttä
n. 1 rkl raastettua inkivääriä
2 tl Garam masalaa
2 tl jauhettua korianteria
1 tl kurkumaa
2 tl kardemummaa
chiliä
suolaa
pippuria$q$, $q$Aja tomaattimurska pyreeksi sauvasekoittimella. Kaada pannule 2-3 rkl neutraalia öljyä tai gheetä. Murskaa valkosipulin kynnet öljyyn ja lisää mausteet suolaa lukuunottamatta. Lämmitä mausteet öljyssä ja freesaa niitä hetki. Lisää kana ja paistele sekoittaen mausteissa kunnes se on ottanut väriä. Lisää tomaatti pyree ja kiehuta kunnes kanat ovat kypsyneet ja curry on sopivan paksuista. Tarkista maku ja lisää tarvittava määrä suolaa. Mikäli tomaatti on hyvin hapanta lisää hieman sokeria. Tarjoa chapatin, riisin ja raidan kera.$q$, NULL),
($q$naudan-kieli$q$, $q$Naudan kieli$q$, $q$Suolaliemi:
400 g merisuolaa (karkea on hyvä)
300g sokeria
6 katajanmarjaa
10 mustapippuria
1-2 laakerinlehteä
Ripaus jauhettua neilikkaa (n ¼ tl)

Kielen keittämiseen:
1-2 sellerin vartta
1 sipuli	
1 porkkana
2 laakerinlehteä
mustapippuria
suolaa$q$, $q$Kiehauta suola liemen ainesosat ja anna jäähtyä. Laita kieli suolaliemeen ja anna marinoitua jääkaapissa n. 5vrk.

Huuhtele kieli, keitä puhtaassa vedessä siten vihannestem kanssa siten että kieli peittyy kokonaan veden alle noin viisi tuntia tai painekattilassa 2 tuntia. Poista nahka pinnalta seuraavasti: vedä pitkittäisviilto kielen tyvestä kärkeen ja käännä nahka molemmin puolin. Siivuta kieli ja tarjoile. Vaihtoehtoisesti voit tehdä kielestä parin sentin paksuisia siivuja, paistaa ne voissa ja tarjota sauce espagnolen tai port viini kastikkeen kera.

Keitetty kieli sopii erinomaisesti kylmänä näkkileivän päälle.$q$, $q$kokonainen naudan kieli$q$),
($q$naudanlihaa-osterikastikkeessa$q$, $q$Naudanlihaa osterikastikkeessa$q$, $q$450 g naudanlihaa (esim. riippunutta sisäpaistia)
1 rkl vaaleaa soijakastiketta
2 tl seesamiöljyä
1 rkl kuivaa sherryä tai valkoviiniä
2 tl maissijauhoja
3rkl osterikastiketta
3 rkl neutraalin makuista öljyä
           1.5 rkl kevätsipulia ohuina (vinoina) renkaina koristeluun$q$, $q$Leikkaa liha poikkisyin 5 cm:n pituisiksi ja 5 mm:n paksuisiksi viipaleiksi. Pane viipaleet kulhoon.

Sekoita soijakastike, seesamiöljy, sherry ja maissijauho lihan joukkoon. Anna marinoitua 20 minuuttia. Sekoita joukkoon hieman öljyä, jotta viipaleet irtoavat helpommin toisistaan paistamisvaiheessa.

Kuumenna wokpannu ja kaada siihen öljy. Kun se on miltei savuavan kuumaa, laita lihaviipaleet öljyyn pienissä erissä ja paista niitä koko ajan käännellen 5 minuuttia tai kunnes ne ovat saaneet hieman väriä.

Nosta lihat öljystä reikäkauhalla ja pane ne valumaan kulhon päälle asetettuun siivilään. Heitä kulhoon valunut öljy pois. 

Pyyhkäise wokpannu talouspaperilla puhtaaksi ja kuumenna se korkealla lämmöllä. Mittaa pannuun osterikastike ja kuumenna se kiehumispisteeseen. 

Kumoa valutetut lihasuikaleet pannuun ja sekoita ne hyvin osterikastikkeeseen. Nosta liha tarjoiluvadille, koristele kevätsipulirenkailla ja tarjoa lämpimänä.$q$, $q$Hyvä osterikastike ei maistu lainkaan kalalle, vaan siinä on pikemminkin lihaisa maku ja siksi se sopii hyvin sekä naudan- että porsaanlihalle.$q$),
($q$naudanlihaa-pinaatti-purjo$q$, $q$Haudutettua naudanlihaa pinaatin ja purjon kera$q$, $q$400 g naudan ulkofileetä
2 rkl vaaleaa soijakastiketta
2 rkl kalakastiketta
3 rkl öljyä
4 hienoksi pilkottua korianterinjuurta
       0.5 dl pilkottuja tuoreita korianterinlehtiä ja -varsia
       2 tl mustapippureita murskattuna
       2 murskattua valkosipulin kynttä
       1 rkl fariinisokeria
       1.25 dl vettä
1 viipaloitu purjo
20 pinaatinlehteä, joista poistettu ruodit
           0.5 dl limettimehua$q$, $q$Viipaloi naudanliha 2,5 cm:n paksuisiksi pihveiksi. Sekoita soijakastike, kalakastike, 1 rkl öljyä, korianteri, pippurit, valkosipuli ja sokeri monitoimikoneessa tasaiseksi. Kaada marinadi lihanpalojen päälle, peitä ja anna maustua vähintään 2 tuntia tai yön yli.

Pyyhi liha kuivaksi, säästä marinadi. Kuumenna 1 rkl öljyä wokissa tai isossa paistinpannussa. Lisää lihat ja ruskista molemmin puolin. Lisää marinadi ja vesi, vähennä lämpöä ja keitä 8 minuttiia. Ota liha pannusta ja pidä lämpimänä. Keitä kastiketta 10 minuttia ja siirrä syrjään. Viipaloi liha suupalan kokoisiksi paloiksi.

Kuumenna loput öljystä wokissa tai kattilassa. Lisää purjo ja pikapaista 2 minuuttia keksilämmöllä. Lisää pinaatti ja keitä 30 sekuntia.

Aseta pinaatti ja purjo tarjoiluvadille lihan kanssa. Kaada kastike lihan päälle ja pirskota joukkoon limettimehu. Koristele halutessasi chiliviipaleilla.$q$, NULL),
($q$north-caroline-style-rub$q$, $q$North Caroline style rub$q$, $q$1.5 tl mietoa paprikaa
(2.5 tl ruskeaa sokeria)
2 tl cayenne pippuria
1 tl sellerisuolaa
1 tl valkosipulisuolaa
1 tl sinappijauhetta
1 tl mustapippuria
1 tl sipulijauhetta
(0.25 tl suolaa)$q$, NULL, NULL),
($q$paistetut-herkkusienet$q$, $q$Paistetut herkkusienet$q$, $q$3 rkl oliiviöljyä
2 valkospilinkynttä
450 g herkkusieniä
2 rkl balsamiviinietikkaa
(4 rkl pinjansiemeniä)
sitruunamehua
suolaa
mustapippuria
2 rkl hienonnettua persiljaa$q$, $q$Kuumenna öljy, lisää hienonnettu valkosipuli ja paista noin 3 minuuttia. Älä ruskista. Lisää sieniviipaleet, etikka ja pinjansiemenet. Hauduta kunnes neste sienistä on haihtunut. Lisää sitruunamehu ja mausteita maun mukaan. Sekoita lopuksi persilja. Tarjoile heti.$q$, NULL),
($q$paistetut-silakat$q$, $q$Paistetut silakat tai pienet siiat$q$, $q$Kokonaisia silakoita, mielellään pieniä / pieniä siikoja
Ruisjauhoa
Voita 
Suolaa$q$, $q$Aloita perkaamalla silakat. Nipistä peukalolla ja etusormella pään takaa tuo poikki siten että pää osin irtoaa. Vedä päätä pyrstöön päin samalla vetäen etusormella suolet ja uimarakon pois mahasta. Huuhdo silakka siten että maha jää puhtaaksi.
Mikäli olet saanut pikkusiikoja irrotetaan pää veitsellä, samoin vatsa auki veitsellä, suolet sekä uimarakko pois ja huuhtominen. Pään voi halutessaan jättää myös paikalleen.
Kierittele silakat/siiat ruisjauhossa. Kuumenna voi pannulla kunnes se ruskistuu ja laita silakat pannulle. Suolaa päälli puoli ja paista kunnes pannulle oleva puoli on tumman ruskea, käännä, suolaa ja toista paistaminen.
Paistettujen silakoiden kaveriksi sopii erinomaisesti uudet perunat ja voi tai majoneesi/Kavlin pikkelsi. Pienet silakat voi syödä ruotoineen ja pyrstöineen, isommista kannattaa irrottaa selkäruoto syödessä.$q$, NULL),
($q$pakastetut-sinisimpukat$q$, $q$Pakastetut sinisimpukat$q$, $q$500 g pakastettuja sinisimpukoita
oliiviöljyä
1 pieni keltasipuli
1 valkosipulinkynsi
murskattua chiliä maun mukaan
kuivattua persiljaa
1 tl paprikajauhetta
suolaa
pippuria
~1 rkl sitruunamehua$q$, $q$Laita pannulle reilusti oliiviöljyä, lisää cili ja paprika, kuullota sipulia mausteisessa öljyssä 2-3 minuuttia, lisää murskattu valkosipuli. Paista kunnes valkosipuli on kullanruskeaa (2-3 minuuttia). Anna hautua hetki ja laita sekaan jäiset simpukat sekä persilja. Hauduta kannen alla välillä sekoitellen, kunnes simpukat ovat sulaneet ja imeneet ihanat maut pannulta. Säädä makua tarpeen mukaan suolalla, pippurilla sekä tilkalla sitruunamehua.$q$, NULL),
($q$paprikakana-unkarilaisittain$q$, $q$Paprikakanaa unkarilaisittain$q$, $q$1 kg kananpaloja (esim broilerin koipireisiä)
1 rkl öljyä
2 sipulia
1 tl paprikajauhetta
1 vihreä chili
1 iso tomaatti
suolaa,
pippuria
           2.5 dl hapankerma / crème fraise
           1 rkl jauhoja$q$, $q$Kuumenna öljy pannussa, kuullota hienoksi silputtu sipuli. Ota pannu pois levyltä, ripottele siihen paprika, sekoita. Laita pannu takaisin kuumenemaan, lisää kananpalat, renkaiksi silputtu vihreä chili, kalttaamalla kuorittu ja neljänneksiin halottu tomaatti, suola ja pippuri. Peitä kannella ja anna hautua miedolla lämmöllä, kunnes liha on kypsää. (Jos tuntuu, että kana on kuivaa, lisäile hieman vettä pannulle silloin tällöin varovasti, varo laittamasta liikaa).
Sekoita jauhot 2-3 rkl:aan hapankermaa, kunnes siitä tulee sileää ja lisää se kanan päälle. Sekoita ja lämmitä pannulla varmistaen, että seos on sopivan paksua, ei liian paksua. Lisää sitten puolet lopusta hapankermasta, laita loppu hapankerma kulhoon ja tarjoa paprikakanan lisukkeena.

Tarjoile linssien kera.$q$, NULL),
($q$parsapasta$q$, $q$Parsapasta$q$, $q$Nippu parsaa
300g pastaa
2 dl kermaa
½ tl minttua
1 pieni sipuli
suolaa, pippuria, oliiviöljyä tai voita
(raastettua kermajuustoa)$q$, $q$Kuori parsa. Hienonna sipuli. Keitä parsaa suolavedessä 4 minuuttia ja ota pois. Laita pasta kiehumaan samaan suolaveteen. Pätki parsa n. 2 cm paloiksi. Paista sipuli rasvassa ja lisää kerma sekä minttu ja säädä maku suolalla ja pippurilla. Hieman ennen kuin pasta on valmista kiehauta kerma ja lisää siihen parsa ja juusto jos käytät sitä. Kun pasta on al dente valuta ja sekoita pannulle. Kiehuta kunnes kerma on imeytynyt. Tarjoa parmesanin ja rieslingin kera.$q$, NULL),
($q$pekoni-pasta$q$, $q$Pekonipasta$q$, $q$Paketti pekonia
1 sipuli
300 g spagettia
Purkki kermaa
2 rkl  heinz ketchuppia
1 Fond du chef beef kuutio
1 tl korianteri jauhetta
1 tl srirachaa
1 tl kuivattua timjamia
½ tl MSG:tä
1 tl limemehua
Suolaa ja pippuria$q$, $q$Silppua sipuli ja pekoni. Laita spagetti kiehumaan suolattuun veteen.
Spagetin kiehuessa paista sipuli, pekoni, timjami ja korianteri oliiviöljyssä pannulla n. 5 minuuttia, lisää kerma ja muut ainesosat sekoittaen kunnes lihaliemitiiviste on liuennut. Pienennä lämpö ja lisää spagetti kun se on valmista. Sekoittele pari minuuttia jotta kastike imeytyy spagettiin. Tarjoa parmesan raasteen kera. Ketchupin voi korvata esim. kirsikkatomaatin paloilla. Oregano sopii ruokaan myös ja vaikkapa ripaus fenkolia.$q$, NULL),
($q$pellavansiemen-leipa$q$, $q$Pellavansiemenleipä$q$, $q$150 g vastarouhittuja pellavansiemeniä
350 g puolikarkeita vehnäjauhoja
pkt tuoretta hiivaa
3.5 dl 32 asteista vettä
10 g hienoa merisuolaa$q$, $q$Murenna hiiva veteen, vatkaa kunnes se on kokonaan liuonnut. Lisää pellavansiemen-jauho-suolaseos ja vatkaa tasaiseksi, kunnes taikina irtoaa palloksi kulhon reunoilta. Lisää hieman jauhoja tarvittaessa. Vatkaa reilusti 6 minuuttia (Kenwood taso 3-4), että taikina ilmaantuu hyvin. Kohota 30 asteisessa  uunissa noin puoli tuntia tai kunnes taikina on kaksinkertaistunut. Ota taikina pois uunista. Aseta uunin pohjalle vuoka, jossa on n. 2 litraa vettä ja aseta uunin lämmöksi 230. Leivo taikinasta pyöreä leipä kääntelemällä varovasti taikinan reunoja sisäänpäin, näin saat leivästä ilmavamman. Aseta leipä uunipellille käännellyt reunat pohjaa vasten. Kohota liinan alla, kunnes uuni on lämmennyt. Tee leipään viillot terävällä veitsellä; ensin leivän reunan ympäri ja sitten leivän pintaan ristikkoviilto. Laita leipä uuniin 30 minuutiksi, ota vesiastia pois uunista ja paista leipää vielä 10 minuuttia. Näin saat leipään rapean kuoren. Uunista pois otettaessa leivän tulisi 'naksahdella'. Kuori on parhaimmillaan hetken vetäydyttyään. Säilytä leipä liinassa, näin kuori pysyy pidempään rapeana. Säilyy huoneenlämmössä hyvänä noin viisi päivää.

Taikinasta voi leipoa myös sämpylöitä, tästä määrästä saa kuusi isompaa tai 8-12 pienempää sämpylää. Paista sämpulät kuten leipäkin, mutta anna olla uunissa ensin vain 20-25 minuuttia ja sitten ilman vesikulhoa 10 minuuttia.$q$, NULL),
($q$perunakiekot$q$, $q$Paahdetut perunakiekot$q$, $q$1 kilo kiinteää perunaa
Oliiviöljyä
Timjamia
Sipulijauhetta
Valkosipulijauhetta
Suolaa$q$, $q$Pese perunat ja viipaloi ne n. 8-10mm paksuiksi kiekoiksi. Keitä kiekot 2% suolavedessä 12 minuuttia. Kaada kulhoon ja anna höyrytä kunnes pinnat ovat kuivat. Lisää öljyä n. 2-3 rkl, ripottele sekaan timjamia, sipuli jauhetta ja valkosipuli jauhetta – n. 2-3 tl kutakin. Sekoita hyvin ja asettele paperittomalle uunipellille. Ripottele päälle hieman suolaa. Paahda perunoita grillivastuksen alla (toinen ritilä paikka ylhäältä) 225C n. puoli tuntia tai kunnes perunat ovat ruskistuneet. Tarjoa esim. pihvin ja pippurikerma kastikkeen kera.$q$, NULL),
($q$pinaattikeitto$q$, $q$Pinaattikeitto$q$, $q$400 g pakastepinaattia
0.5 l lihalientä
1 dl kermaa
suolaa 
pippuria
cayenne
(sitruunamehua)$q$, $q$Kuumenna voi pannulla. Lisää sipuli ja pinaatti, freesaa, kunnes sipuli on kullankeltaista. Älä päästä sipulia kuitenkaan ruskistumaan. Laita lihaliemi ja sipuli-pinaattiseos tehosekoittimeen ja jauha seos sileäksi. Lisää lientä tarvittaessa. Kaada keitto takaisin kattilaan, lisää kerma ja mausteet. Kuumenna kiehumispisteeseen, tarkista maku, korjaa tarvittaessa pienellä tilkalla sitruunamehua.$q$, NULL),
($q$piri-piri-marinadi$q$, $q$Piri-piri marinadi$q$, $q$½ dl oliiviöljyä
½ dl punaviinietikkaa
½ dl sitruuna tai lime mehua
½ tl juustokuminaa (jeera)
1 tl paprikajauhetta
1 tl cayenne pippuria
2 tl rosmariinia
6 valkosipulin kynttä$q$, $q$Laita purkkiin nesteet, lisää mausteet, purista sekaan valkosipuli. Sulje purkin kansi ja ravista – valmista käytettäväksi.$q$, NULL),
($q$piripiri-mausteliemi$q$, $q$Mausteliemi kanalla – piri-piri style$q$, $q$Litra vettä
60g suolaa
½ tl jeeraa
1 tl paprikajauhetta
½ tl chilijauhetta
1 tl rosmariinia
1 tl valkosipulijauhetta$q$, $q$Kiehauta, jäähdytä, lisää 1 rkl viinietikkaa ja 1 rkl lime- tai sitruunamehua
Marinoi kanoja vuorokausi liemessä, piri-piri kastiketta pintaan ja grilliin.$q$, NULL),
($q$pork-vindaloo$q$, $q$Pork Vindaloo$q$, $q$2 tl juustokuminan (jeera) siemeniä
2 tl garam masalaa
2 tl paprikajauhetta
1 rkl tuoretta, raastettua inkivääriä
6 valkosipulin kynttä hienonnettuna
8 pientä tuoretta punaista chilipalkoa hienonnettuna
1 rkl valkoviinietikkaa
1 rkl tamarindi konsentraattia
1 kg possua kuutioina
2 rkl voita tai neutraalin makuista kasviöljyä
400 g keltasipulia silputtuna
1-2 tl jauhettua kanelia
1-2 tl jauhettua neilikkaa
2 rkl jauhoja
1 litra lihalientä
8 curryn lehteä$q$, $q$Lämmitä kumina, garam masala ja paprikajauhe laakealla kuivalla pannulla, jotta maut irtoavat.  Kun seos on viilentynyt, lisää inkivääri, valkosipuli, chilit, viinietikka, tamarindi ja kuutioksi pilkottu liha. Anna marinoitua viileässä noin tunnin ajan. Sulata voi pannulla, freesaa sipulit, kanlei ja neilikka, kunnes sipulit ovat kullan ruskeita. 

Lisää liha marinadin kanssa, paista noin 5 minuuttia tai kunnes liha on kevyesti ruskistunut. Ripottele jauhot lihan päälle ja sekoita. Lisää lihaliemi. Hauduta noin puoli tuntia kannen alla, poista kansi ja hauduta toiset puoli tuntia kunnes curry on redusoitunut paksuksi kastikkeeksi. Lisää tarvittaessa suolaa lopuksi. Huom, riippuen jauhon määrästä ja lihasta irtoavasta nesteestä 1 litra lihalientä voi olla liikaa, kannattaa aloittaa hieman päälle puolella litralla ja lisätä tarpeen mukaan.$q$, NULL),
($q$possun-posket$q$, $q$Porsaan posket keitettynä$q$, $q$1 kg possun poskia
2 kuorittua sipulia
2 kuorittua porkkanaa
2 puhdistettua purjoa
2 vartta selleriä
2 valkosipulin kynttä
2 sitruunan mehu
punaviinietikkaa
nippu tuoreita yrttejä esim. Timjami, persilja
vastarouhittua mustapippuria
suolaa$q$, $q$Laita juurekset ja vihannekset kattilaan, laita posket niiden päälle (näin vältyt lihan palamiselta pohjaan mikäli lämpöä on liiaksi), peitä vedellä siten että vettä on pari senttiä lihojen päällä ja lisää mausteet. Kun liemi alkaa kiehua, poista vaahto pinnalta. Keitä, kunnes liha on pehmeää, noin 2,5 tuntia.$q$, NULL),
($q$possun-posket-uunissa$q$, $q$Porsaan posket uunissa$q$, $q$N. 1 kg possun poskia
suolaa
timjamia$q$, $q$Suolaa possunposket ja laita ne uunivuokaan. Ripottele päälle hieman timjamia. Peitä vuoka huolellisesti foliolla ja laita uuniin 120 asteeseen kuudeksitoista tunniksi. Tämä ruoka kannattaa siis valmistella uuniin illalla ennen nukkumaanmenoa. Kuudentoista tunnin kuluttua ota vuoka uunista ja poista folio. 

Posket ovat kypsyneet omassa liemessään ihanan ylikypsiksi samalla kun niitä joskus vaivaava karvas maku on poistunut. Tarjoa posket liemen kanssa vaikkapa selleripyreen ja piparjuurimajoneesin kanssa.$q$, $q$Tämä on uskomattoman yksinkertainen mutta maukas slow food resepti.$q$),
($q$possunposket-portugalilaisittain$q$, $q$Possun posket portugalilaiseen tapaan$q$, $q$1 kg possun poskia /
3-5cm paloja kasleria
1 iso sipuli silputtuna
3 valkosipulin kynttä viipaleina
1 purkki tomaattimurskaa
2-3 dl punaviiniä
1 sitruunan kuori suikaleina
4 laakerinlehteä
1.5 tl Savupaprikajauhetta
1.5 tl suolaa
0.5 tl Jeeraa (juustokumina)
pippuria$q$, $q$Lisää possunposkiin suola ja paprikajauhe sekä jeera jos käytät sitä, kierittele jotta mausteet päätyyvät joka puolelle ja anna maustua noin tunnin verran. 
Paista possunposket pannulla öljyssä kunnes ovat saaneet hieman ruskeutta pintaan. Ota posket lepäämään ja freesaa sipuli pannussa lisäten öljyä tarvittaessa. Kun sipuli on kuullottunut lisää valkosipuli ja paista 1-2 minuuttia lisää. Lisää tomaaattimurska ja laakerin lehdet ja lämmitä kiehuvaksi. Lisää punaviini ja kiehuta kunnes alkoholi on haihtunut ja kastike paksuuntunut. Mausta suolalla ja pippurilla ja tarvittaessa ruokosokerilla. Lisää sitruunankuori suikaleet.

Laita possunposket kastikkeeseen ja kauho kastike poskineen sous videe pussiin. Kypsennä 74C asteessa 24 tuntia.

Ota posket kastikkeesta ja poimi pois sitruunan kuoret ja laakerin lehdet. Kiehuta kasaan ja lopuksi hienonna sauvasekoittimella. Säädä mausteet. Laita posket takaisin kastikkeeseen, kiehauta ja tarjoa esim. sokeriherneiden, pikkuporkkanoiden ja trofien kera.$q$, NULL),
($q$pulled-pork$q$, $q$Pulled Pork$q$, $q$Rasvainen sianlihan pala, kasler, etuselkä, lapa

North Carolina rub (n. 50ml):
4 tl paprika jauhetta
8 tl ruokosokeria
6 tl cayenne pippuria
2 tl seller suolaa
2 tl valkosipuli jauhetta
2 tl sipulijauhetta
2 tl sinappi jauhetta
1 tl suolaa

Savuaromia$q$, $q$Kierittele lihan pala rubissa tai ripottele rubia sen pintaan runsaasti. Laita liha pataan ja kaada päälle savuaromia, n. 1/2-1 tl / kilo. Laita padan kansi kiinni ja laita liha uuniin 80C lämpöön 24 tunniksi. 
Ota liha uunista ja revi se suikaleiksi käyttäen haarukkaa ja veistä. Poista samalla luut mikäli niitä oli palassa. Sekoita revitty liha padan pohjalla olevaan nesteeseen ja lisää tarvittava määrä suolaa.

Pulled pork toimii hyvin coleslawn kanssa ja erilaisissa leivissä ja sämpylöissä tai vaikka ihan ranskisten kanssa. North Carolina viinietikka kastike on mainio lisuke tälle vedetylle sialle.

North Carolina vinegar sauce

n. 100 ml punaviinietikkaa
2 tl chiliflakesejä
1 tl suolaa
1 tl pippuria
1 rkl ketchuppia
1 rkl ruokosokeria

Sekoita aineet ja anna maustua hetki$q$, NULL),
($q$pyttipannu-thoughts$q$, $q$Ajatuksia pyttipannusta$q$, NULL, $q$Pyttipannu on nimi joka helposti yhdistetään johonkin tähteistä kasattuun hätäapuruokaan. Todellisuudessa pyttipannu voi olla erittäin herkullinen ruoka jota mielihyvin syö kaikkine lisukkeineen vaikka illalliseksi. 

Pyttipannun rakentuu perunoiden ympärille joten hieman ajatuksia perunoista ja niiden paistamisesta. Kaikkein herkullisimpia ovat raakana paistetut perunat mutta näiden tekeminen on työlästä pitkästä paistoajasta johtuen ja isomman määrän tekemiseen ei yksi pannu riitä koska raakana paistetut perunat pitää kuutioida hyvin pieniksi (max. 5mm/sivu) jotteivät ne jää raaoiksi sisältä. Mikäli olet tekemässä pientä määrää pyttipannua ja aikaa on käytettävissä suosittelen raakana paistettuja perunoita, muussa tapauksessa kannattaa käyttää keitettyjä perunoita jotka voi kuutioida isommiksi (n. 10mm/sivu) jolloin niitä pystyy paistamaan n. 6 hengen annoksen isolla pannulla. Perunalajike on kriittinen asia jos halutaan tehdä hyvää pyttipannua, rehuperunan maku tulee aina läpi ja pilaa pyttipannun. Suositeltavia lajikkeita ovat kiinteät perunat, näistä Siikli ja Annabella ovat varmoja valintoja joskin Siiklin huonontuneen siemenperunan laadun johdosta kannattaa olla tarkkana millaista Siikliä ostaa. Paras pyttäri syntyy peinistä uusista perunoista jotka pilkotaan kuorineen mutta hyvää tulee vanhemmistakin perunoista kunhan ne kuorii.

Pyttipannuun voi käyttää monenlaista lihaa, onhan kyseessä alunperin ruoka johon on käytetty tähteitä. Itse käytän aina jos mahdollista pekonia ja makkaraa. Pekonista irtoaa rasvaa joka maustaa perunat ja hyvä kokoliha makkara tuo annokseen mukavasti pureskeltavaa. Vaihtoehtoisesti voi kokeilla erilaisia makkaralajikkeita, tulisempia versioita tuomaan pikanttia säväystä tai vaikkapa sipuli-teeluu makkaraa josta normaalisti tehdään Porilaisia. Pekoni on parhaimmillaan pieninä kuutioina mutta siivupekonin voi myös leikellä hienoksi. Makkaran palojen tulisi vastata kooltaan suurinpiirtein perunan paloja. Pyttipannuun käytetään usein sianlihan jämäpaloja esim. kinkusta, mutta kannattaa muistaa että tällöin pyttipannukin maistuu kinkulta mikä ei varsinkaan joulun jälkeen ole välttämättä toivottu asia. Kannattaa myös pitää mielessä että voimakkaan makuiset makkarat peittävät helposti alleen perunoiden miedon maun.

Perinteisesti pyttipannuun laitetaan sipulia, se voi olla pieninä paloina tai siivuina tai jopa sipuli jauheen muodossa joka ei itseasiassa ole ollenkaan huonompi tapa tehdä pyttipannua.

Pyttipannun maustamisessa suola on pääasia ja sen lisäksi voi käyttää hieman MSG:tä ja sipulijauhetta kuten edellä mainittiin. Paistorasvaksi suosittelen oliiviöljyä tai voita pekonirasvan lisukkeena.

Jos pyttipannu halutaan rakentaa kunnolla tai sitä tehdään enemmän kannattaa ainesosat paistaa erillään. Aloitetaan pekonilla jotta saadaan siitä rasva irti, siirretään pekoni syrjään ja paistetaan perunat jotka ottavat kauimmin aikaa. Sitten makkarat, sipulit ym. Ja lopuksi yhdistetään kaikki ainesosat esim. kulhoon. Tämä vapauttaa pannun pyttipannun ykkös lisukkeelle eli paistetulle kananmunalle jotka yleensä tarjoillaan pannulta pyttipannu annoksen päälle.. Keltuainen kannattaa jättää ehjäksi jolloin se rikotaan ja valutetaan pyttipannu keon päälle.

Muita klassisia lisukkeita ovat suolakurkku ja etikkapunajuuri kuutiot. Vaikka pyttipannu on herkullista ihan noinkin pisteen I:n päälle tuo vielä Heinzin ketchuppi jota voi lorotella kaiken päälle mielensä mukaan.$q$, NULL),
($q$ranskalainen-sipulikeitto$q$, $q$Ranskalainen sipulikeitto$q$, $q$800 g keltasipuleita
(4 valkosipulin kynttä)
voita paistamiseen
1 l lihalientä
3 dl valkoviiniä
rouhittua mustapippuria
timjamia
suolaa
juustoraastetta maun mukaan esim. Gryere$q$, $q$Leikkaa sipulit ohuiksi viipaleiksi, hienonna valkosipuli. Sulata voi pannulla tai kattilassa ja kuullota siinä sipulit kullanruskeiksi, ei liin tummiksi. Lisää lihaliemi, viini ja mausteet, hauduta noin tunti, lisäile nestettä tarvittaessa. Tarkista maku. Jaa keitto uunin kestäviin pienempiin vuokiin, ripottele päälle reilusti juustoraastetta ja kuorruta juusto keiton päälle 225 asteisessa uunissa kunnes juusto on sulanut ja hieman ruskistunut.$q$, NULL),
($q$rubbeja$q$, $q$Rubbeja Steven Reichlenin mukaan$q$, NULL, $q$Rubbit ovat varsin monikäyttöisiä mausteseoksia, käytetään lihan pintaan hierottuna tai joitain näistä
voi käyttää esim. ranskis mausteena tai jopa poppareille. Chimichurrista saa myös hyvän marinadin
lihalle.
Kuiva chimichurri
1 tsp oreganoa
1 tsp basilikaa
2 tsp paprika jauhetta
1 tsp timjamia
1 tsp chilijauhetta tai cayenne pippuria
1⁄2 tsp suolaa
1⁄2 tsp pippuria
Tästä tehdään chimichurri marinadi sekoittamalla 1 rkl kuivamaustetta, 1 rkl punaviini etikkaa ja 1 rkl
oliiviöljyä keskenään. Siitä voi myös tehdä maustevoin sekoittamalla kuivamaustetta ja hieman
punaviinietikkaa voihin.
Creole rub
3 tsp paprika jauhetta
2 tsp suolaa
1 tsp valkosipulijauhetta
1 tsp sipulijauhetta
1 tsp pippuria
1 tsp cayenne pippuria
1 tsp timjamia
1 tsp oreganoa
Optiona
1 tsp sellerisuolaa
1 tsp sinappijauhetta
1tsp MSG:tä
Erittäin hyvä grillatun kanan nahkaan, voi käyttää kuten grillimaustetta
Jerk rub
2 tsp timjamia
4 tsp cayenne pippuria tai chiliä
1.5 tsp maustepippuria jauhettuna
2 tsp paprikajauhetta
2 tsp suolaa
2 tsp pippuria
1 tsp neilikkaa
1 tsp kanelia
1 tsp ruokosokeria
2 tsp sipulijauhetta$q$, NULL),
($q$schnitzel$q$, $q$Wiener Schnitzel$q$, $q$Palat: Naudan sisäpaisti tai paahtopaisti, sian ulkofile tai kasler, kanan tai kalkkunan rinta filee

Korppujauhoa
Kananmunia, n. 1 muna / 2 pihviä
Sinappi jauhetta
Paprika jauhetta
Suolaa
Öljyä paistamiseen$q$, $q$Leikkaa lihasta n. sentin paksuisia siivuja ja nuiji ne 2-3 kertaan puisella leikkuu laudalla n. 3mm paksuiksi pihveiksi.
Sekoita kananmunat, sinappijauhe ja paprika jauhe vispilällä laakeahkossa kulhossa.
Laita korppujauho lautaselle jossa tartutat sen munaseoksessa uitettujen pihvien pintaan.

Lämmitä öljy pannulla, laita pihvit yksi kerrallaan muna seokseen siten että ne ovat kauttaaltaan seoksen peitossa. Laita pihvit korppujauho lautaselle ja kääntele kunnes korppujauho on tarttunut kaikille pinnoille. Laita pihvi pannulle suolaa ja paista yksi puoli kerrallaan kunnes korppujauho on kauniin ruskeaa 1-2 min / puoli. Pihvin paistuessa valmistele seuraava pihvi, siivoa keittiö ruuan jälkeen.

Kuten lehtipihvikin tämä pihvi toimii erinomaisesti bearnaise ja pippurikerma kastikkeiden kanssa. Klassiset lisukkeet ovat ranskalaiset ja herneet.$q$, NULL),
($q$sinihomejuusto-kana$q$, $q$Sinihomejuusto-pekoni kana$q$, $q$6 puolitettua kanan rintaa, minuuttileike, fileeleike ym. nimillä myytäviä
60g sinihomejuustoa, blå castello on helpoin tähän ruokaan
60g voita tai hyvää voipohjaista margariinia joka on helpompi sekoittaa tahnaksi
persiljaa, kuivakin käy
paketti pekonia, tai kaksi
1.5 dl valkoviiniä
1.5 dl kanalientä
ruokokidesokeria
ruskeaa suurustetta tai maizenaa suurustamiseen
60g suolaa
1 litra vettä$q$, $q$Tee suolaliemi sekoittamalla kylmä vesi ja suola, laita kananrinnat suolaantumaan liemeen 1-2 tunniksi. Tämä vaihe jää välistä jos käytät valmiiksi suolattuja kananrintoja.

Sekoita voi, sinihomejuusto ja persilja keskenään tahnaksi.

Katkaise pekonin siivut keskeltä ja paista puolikkaat.

Aloita kastikkeen teko laittamalla viini ja kanaliemi kattilaan sekä kaatamalla sinne pekonin rasva ja 1 rkl sinihomejuusto tahnaa. Kiehauta alkoholi pois.

Kun kanat ovat suolaantuneet laita niihin pippuria pintaan ja paista voissa kypsiksi, 66C sisälämpötila. Glaseeraa pannu kastikkeella, suurusta kastike ja säädä lopuksi maku suolalla, pippurilla ja ruokosokerilla.

Levitä kananrintojen päälle sinihomejuustotahnaa ja asettele päälle 2 pekonin siivua tai pekonimurua.

Tarjoa trofie tai bavette pastan kera runsaalla kastikkeella höystettynä.$q$, NULL),
($q$sinisimpukat-valkosipuli$q$, $q$Sinisimpukoita ja valkosipulia$q$, $q$900 g tuoreita sinisimpukoita
1 sitruunan viipale
90 ml oliiviöljyä
2 shalottisipulia
1 valkosipulin kynsi
I rkl hienonnettua persiljaa
        0.5 tl paprikajauhetta
           0.25 tl kuivattua chilirouhetta$q$, $q$Tarkista simpukat; käytä vain ne, jotka avautuvat kopautuksesta. Laita simpukat isoon pannuun tai kasariin, lisää 250 ml vettä ja sitruunansiivu. Anna kiehua 3-4 minuuttia; poista simpukat sitä mukaa kuin ne avautuvat. Poista ne, jotka eivät avaudu. Ota simpukat kuoristaan ja anna kuivahtaa talouspaperin päällä. Kuumenna öljy laakealla pannulla, lisää simpukat, anna tiristä minuutin verran. Lisää shalotit ja valkosipuli, hauduta miedommalla lämmöllä viisi minuuttia, kunnes ne pehmenevät. Ota pannu pois levyltä, lisää persilja, paprika ja chili. Lisää simpukat pannulle. Lämmitä hetki ja tarjoa heti.$q$, NULL),
($q$sitruunakana$q$, $q$Sitruunakana$q$, $q$3-4 kanankoipipalaa (maustamatonta)
oliiviöljyä
sitruunamehua
suolaa
pippuria
yrttejä esim. Rosmariinia
kermaa
maissijauhoa$q$, $q$Valele koivet öljyllä ja sitruunamehulla, ripottele päälle mausteet. Laita kanat uunivuossa 175 asteiseen uuniin noin tunniksi. Ota neste vuoasta talteen, lisää joukkoon kermaa ja paksunna kastikkeeksi maissijauholla. Lisää tarvittaessa suolaa.

Tarjoile haluamasi salaatin kera.$q$, NULL),
($q$sitruunavaahto$q$, $q$Sitruunavaahto$q$, $q$10 kpl liivate lehtiä
6 munaa
1.5 dl sokeria
2 sitruunan mehua ja raastettu kuori, limejä 3-4 kappaletta jos tehdään lime vaahto
6 dl kuohukermaa$q$, $q$Liota liivatelehdet kylmässä vedessä
Raasta sitruunan kuori ja purista mehu
Erottele valkuaiset keltuaisista
Vatkaa valkuaiset kovaksi vaahdoksi
Vatkaa sokeri ja keltuaiset vaaleaksi ja kuohkeaksi vaahdoksi
Vatkaa kerma vaahdoksi
Puserra liivatteet ja lämmitä kattilassa tilkassa mehua kunnes ovat liuenneet
Sekoita ainekset keskenään ja laita jääkaappiin vähintään kolmeksi tunniksi. Jos on kiire niin
pakastimeen.$q$, $q$Myös limeversio on varsin toimiva, tekee n. 10 annosta$q$),
($q$sousvide-tietoa$q$, $q$Sous vide ja naudanliha$q$, NULL, $q$Sous vide ja naudanliha

Sous vide eli vesihaude on mainio tapa paistettavaksi tai grillattavaksi tarkoitettu naudan liha. Tyypillisesti naudanliha laitetaan kokonaisena palana tyhjiöpussiin ja sous videe käsittelyn jälkeen leikataan pihveiksi tai valmistetaan kokonaisena. Ennen tyhjiöpussiin laittamista liha on syytää ainakin suolata ripottelemalla reilusti suolaa palan pinnoille ja varsinkin enemmän rasvaa ja sidekudosta sisältävät palat (entrecote, picanha, maminha etc.) hyötyvät marinaadin lisäämisestä pussiin. Sisäfileen ja jänteetömän ulkofileen ollessa kyseessä riittää n. 2 tunnin pito sous videessä mutta sitkeämmät ja sidekudosta sisältävät palat kannattaa laittaa kylpyyn 24 tunnin ajaksi.

Sisäfile ja jänteetön ulkofile

Puhdista liha ja tarvittaessa leikkaa sisäfile kahtia jotta se mahtuu vesiastiaan. Suolaa pinnat ja laita vakuumi pussiin. Kypsennä sous videessä 54 asteessa 2 tuntia (medium rare) tai sama aika 52 asteessa (rare) jolloin saadaan kauniin punainen sisus pihviin.  Ota palat pussista, kuivaa ja leikkaa pihveiksi. Paista pannulla voissa. Ulkofile ja sisäfile ovat normaalisti varsin rasvattomia paloja joten grillausta ei suositella.

Muut naudanlihan palat, entrecote, picanha, maminha, bavette, flat iron steak jne.

Puhdista palat ja suolaa ne reilulla kädellä, ohuempia paloja hieman varovaisemmin. Tee Steve Raichlinin BBQ biblen mukainen kuiva chimichurri seos. Noin kilon palaan sekoita keskenään 1 rkl mauste seosta, 1 rkl punaviinietikkaa ja 1 rkl öljyä (rapsi tai oliivi). Marinadissa oleva etikka auttaa lihaa mureutumaan ja chimichurrin maku sopii loistavasti grillatulle lihalle.

Kuiva chimichurri:
1 tsp kuivattua oreganoa
1 tsp  kuivattua basilikaa
2 tsp paprikajauhetta
1 tsp  kuivattua timjamia
1 tsp chilijauhetta tai cayenne pippuria
½ tsp suolaa
½ tsp jauhettua pippuria

Laita marinadi vakuumipussin pohjalle (muista tupla saumat kun teet pussia), liha perään ja sulje pussi vakuumiin. Pieni määrä marinadia saatta tulla ulos vakumoitaessa mutta pääsääntöisesti se jää lihaan. Laita liha sous videeseen 56 asteeseen ja anna olla n. 24 tuntia. Tämä hieman korkeampi lämpö on tarpeen jotta bakteeri toimintaa ei pääse kehittymään pidemmän sous videe pidon aikana, jos asia epäilyttää niin 56.5C on myös testattu ihan toimivaksi.

Sous videe pidon jälkeen ota liha pussista ja valmitele se grillattavaksi. Entrecote kannattaa leika pihveiksi joiden pinnalle ripotellaan suolaa. Picanha ja maminha grillataan yleensä kokonaisina ja leikataan sen jälkeen pihveiksi jotka voi edelleen grillata tai tarjota sellaisenaan hieman suolalla höystettynä. Bavette ja flat iron steak menevät grilliin tai pannulle sellaisenaan ja leikataan tyypillisesti pöydällä tai lautasella. Nykyään on saatavilla sellainen kirjo näitä harvinaisempia naudan leikkauksia etten ala niitä läpi käymään, pääsääntöisesti voidaan todeta että ohuet palat grillataan/paistetaan sellaisenaan ja paksummista kannattaa pasitaa pinnat ja sitten leikata pihvit jotka voi edelleen paistaa. Maldons suolaa on hyvä laittaa tarjolle silloin kun palat leikataan pöydässä tai lautasella.$q$, NULL),
($q$sveitsi-fondue$q$, $q$Klassinen sveitsiläinen fondue$q$, $q$1 valkosipulinkynsi
2.5 dl kuivaa valkoviiniä
1 tl sitruunamehua
250g raastettua gryerea
250 g raastettua emmentalia
2 tl maissitärkkelysjauhoja
2 rkl kirschiä tai muuta (hedelmä)viinaa
muskottipähkinää
pippuria$q$, $q$Hiero padan sisäpuoli halkasitulla valkosipulinkynnellä.

Mittaa pataan viini ja sitruunamehu. Kuumenna lähes kiehuvaksi, vähennä lämpöä ja lisää vähitellen juustoraasteet. Kuumenna hitaasti koko ajan sekoitellen, kunnes juusto sulaa ja seos on tasaista.

Sekoita maissijauhot kirschiin ja valuta suurus ohuena nauhana pataan edelleen sekoitellen. Kuumenna vielä 2-3 minuuttia, kunnes seos on sakeaa ja sileää. Älä anna fondyyn kiehua. Mausta kevyesti pippurilla ja muskottipähkinällä. Nosta pata pöytään kiettimen päälle ja pidä pienellä liekillä lämpimänä. 

Tarjoile lisänä erilaisia vihanneksia esim. Broccolia, kukkakaalia, höyrytettyjä porkkanan paloja (pellavasiemenleipä kuutioita).$q$, NULL),
($q$tafelspitz$q$, $q$Keitettyä naudan etuselkää punajuuren kera (Tafelspitz)$q$, $q$Liha:
 800 gr naudan luutonta etuselkää, rasvaisuus on plussaa / Naudan picanha Tafelspitzeen
1 sipuli halkaistuna
1 porkkana halkaistuna
1 varsisellerin varsi paloina
1-2 valkosipulin kynttä halkaistuina
n. 10 mustapippuria
Laakerinlehti
Suolaa 8 grammaa / litra, vettä

Punajuuri raaste:
Raasta n. 200g pientä punajuurta / ruokailija. Mausta suolalla ja pippurilla ja sekoita.$q$, $q$Liha:
Laita kaikki ainekset kattilaan siten että etuselkä on veden peitossa, kiehauta, kuori vaahto ja tarkista suolan määrä. Keitä n. 4-6 tuntia kunnes liha on ylikypsää tai 2+ tuntia painekattilassa.

Punajuuri:
Raasta n. 200g pientä punajuurta / ruokailija. Mausta suolalla ja pippurilla ja sekoita. 

Asettele punajuuri lautasille röykkiöksi ja tipauta päälle reilu pallukka crème freichea. Lisää reilu pala lihaa lautaselle ja kunnon nokare piparjuuri majoneesia yhdistämään makuja.

Tafelspitz, tarjoa lihan kanssa lientä, spätzlejä ja keitettyjä juureksia (porkkana, peruna, juuriselleri) piparjuurimajoneesin kanssa$q$, $q$Fergus Hendersonia lainaileva erittäin maukas ja rustiikkinen ruokalaji jossa piparjuuri yhdistää punajuuren ja lihan maut mahtavalla tavalla.$q$),
($q$thaikeitto$q$, $q$Thaikeitto$q$, $q$1 rkl vihreää tai punaista curry tahnaa
1 pieni sipuli julienne
1 pieni porkkana julienne
5cm pala inkivääriä kuorittuna julienne
1 valkosipulinkynsi ohuina siivuina
1 tl sitruuanruokoa
1 tl limemehua
1 tl srirachaa
1 tl kalakastiketta
0.5l kanalientä$q$, $q$Sekoittele curry tahnaa kuumassa öljyssä kunnes se on juoksevaa ja kuplii hieman. Lisää muut ainekset ja paista kunnes ne hiukan pehmenevät. Lisää kanaliemi ja kiehauta. Lisää mausteet.

Liha (kypsä) ohuina suikaleina tai kuutioina tekee keitosta tuhdimman. Halutessa voi lisätä myös hieman nuudeleita, jolloin hiilihydraattien määrä nousee.$q$, $q$Thaikeitto kahdelle$q$),
($q$tomaattikastike$q$, $q$Tomaattikastike$q$, $q$400 g tomaattimurskaa tai -paseeta
suolaa
pippuria
2-3 valkosipulinkynttä
kuminaa
korianteria
0,5 rkl viinietikkaa
chilitahnaa (srirachaa)
(oreganoa)$q$, $q$Laita kaikki aineet tehosekoittimeen ja hurauta kastikkeeksi.

Sopii dippaukseen sekä lihalle.

Salsakasti on kuten tomaattikastike, mutta lisää hyvin hienoksi silputtu isohko sipuli kastikkeeseen.$q$, NULL),
($q$tournedos-chateaubriand$q$, $q$Tournedos ja Chateaubriand$q$, $q$Naudan sisäfileestä 4cm paksuisia siivuja
Suolaa ja pippuria pintoihin$q$, $q$Valitaan välineistön mukaan miten pihvit kysytetään, vaihtoehdot:
Sous vide + pannu + voi, 52-54C sous vide 2 tuntia, pannulla 2 min / puoli
Pannu + uuni, paistetaan pinnat pannulla ja uuniin 150C mittarin kanssa kunnes sisälämpö noin 48-50C
Pannu, paistetaan 2 min / puoli ja tökitään lihaa kunnes arvioitu haluttu kypsyys on saavutettu. Siinä 8 minuuttia ja aavistuksen kiinteytynyt sisältä mutta edelleen pehmeä.

Voin pitää muodostaa ruskeahkoa vaahtoa pannulla, tällöin oikea lämpötila on saavutettu. Älä laita liikaa lihaa kerralla pannulle ettei lämpö putoa, pannun pitää olla KUUMA. Tarvittaessa ota pihvit pois kääntövaiheessa ja anna pannun lämmetä uudelleen – tämä on tarpeen jos pihveistä alkaa tulla nestettä ulos pannulle.

Tournedoksesta löytyy N kpl. variaatioita mutta yleensä se tarjotaan punaviini/portviini kastikkeen tai pippurikerma kastikkeen tai jonkin sen variaation kera (esim. Mornay). Myös sienikastikkeet toimivat mainiosti ja pihvin ympärille voi kääräistä pekonisiivun ennen paistamista. Tournedoksesta voi myös tehdä pippuripihvin näin halutessaan. Tyypillinen hienostelu resepti on Tournedos Rossini jossa on ankan maksaa ja tryffeliä päällä, jos jostain löydätte ainesosat tuohon niin tulen mielelläni syömään. Tournedos Henry neljäs on jo hieman maanläheisempi versio jossa kanapeen päälle laitetaan pihvi punkku kastikkeella, pihvin päälle bearnaise kastikkeella täytetty artisokan pohja ja kaveriksi voi perunaa ja parsaa. Niin kuin näkee nuo reseptit menevät helposti työlään puolelle ja tosiasia on että Tournedos on hyvää vaikka ihan maustevoinappi päällänsä ranujen kanssa.


Chateaubriand

Chateaubriand eroaa Tournedoksesta paksuudeltaan joka on n. 2cm sekä myös siinä että se usein tehdään naudan ulkofileestä. Voidaan siis puhua edullisemmasta pihvistä ja Chateubriand ulkofileestä on myös pinta-alaltaan suurempi jolloin siihen tulee enemmän paistopintaa. Ohuempana pihvinä chateaubriand on helppo tehdä pannulla, 2 minuuttia / puoli riittää, suola ja pippuri toki pintaan ensin. Mikäli liha on hieman kovaa kuten ulkofile usein on hyötyy chateubriand parin tunnin sous-vide käsittelystä tai vaihtoehtoisesti marinoinnista, molemmat mureuttavat pihviä joskin marinointi muuttaa lihan makua. Oma suositukseni on tarkistaa lihan pehmeys sormella tökkäämällä, jos siitä ei jää kuoppaa niin sous-vide 2 tuntia 52C. Reseptejä löytyy joka lähtöön mutta yleensä port viini kastike tai pippurikerma/juustokastike ja sopivat lisukkeet maustevoinapin kanssa tekevät tehtävänsä.$q$, $q$Chateaubriandia varten ulkofileen voi myös paistaa kokonaisena ja siivuttaa sitten tarjoamista varten. Tämä on klassinen tapa mutta IMO toimii paremmin grillatun lihan kanssa, pihvissä paistopinta on se juttu.$q$),
($q$trivialeipa$q$, $q$Trivia leivät$q$, $q$2 sämpylää
paketti pekonia
1/2 tomaatti
2 siivua epäjuustoa (cheddar tuorejuusto)
Salaatin lehti
Balsamico reductiota
Suolaa
Pippuria
Majoneesia (ei välttämätön)$q$, $q$Puolita pekoni paketti ja paista siivut pannulla rapeiksi.
Puolita sämpylät ja paista pekonirasvassa.
Siivuta tomaatti ja lado alimmaisen sämpylän puoliskon päälle kerros siivuja.
Sirottetele tomaatin päälle suolaa ja pippuria sekä ripottele päälle balsamicoa.
Tomaatin päälle pekonikerros, pekonin päälle juusto, ruskista juusto kevyesti kaasupolttimella ja laita juuston päälle salaattia.
Jos pekoni oli vähärasvaista laita sämpylän kanteen majoneesia ja kansi paikalleen. Nauti.$q$, $q$kahdelle$q$),
($q$vihrea-kanacurry$q$, $q$Vihreä kanacurry$q$, $q$1 rkl öljyä
1pilkottu sipuli
2 rkl vihreää currytahnaa
4 dl kookosmaitoa
1 dl vettä
500 g broilerin reisipaloja suupalan kokoisiksi paloiteltuna
100 g vihreitä papuja lyhyiksi paloiksi leikattuna
6 kaffirlimetinlehteä
1 rkl kalakastiketta
1 rkl limettimehua
1 tl hienoksi raastettua limetin kuorta
2 tl fariinisokeria
0.5 dl tuoreita korianterin lehtiä$q$, $q$Kuumenna öljy wokissa tai paksupohjaisessa kattilassa. Lisää sipuli ja currytahna ja paista 1 minuutti koko ajan sekoittaen. Lisää kookosmaito ja vesi, kuumenna kiehuvaksi.

Lisää broilerinpalat, pavut ja limetinlehdet, sekoita. Vähennä lämpöä ja keitä hiljalleen 15-20 minuuttia tai kunnes broileri on kypsää.

Lisää kalakastike, limettimehu, limetinkuori ja sokeri, sekoita. Koristele tuoreilla korianterinlehdillä juuri ennen tarjolle viemistä. Tarjoa linssien kera.$q$, $q$Noin 4 annosta$q$),
($q$voikananpoika$q$, $q$Voi-kananpoika$q$, $q$900 g broilerin paloja
4 rkl öljyä
1 tl suolaa
2 tl limettimehua

marinadi:
4,5 dl jogurttia
6 valkosipulin kynttä
2 rkl tuoretta inkivääriä raastettuna
1 tl chilijauhetta
0.25 tl korianterijauhetta
0.5 tl jauhettua juustokuminaa (jeeraa)
0.5 tl jauhettua garam masalaa

kastike:
700 g tomaatteja
0.5 tl kuivattuja sarviapilan lehtiä
75 g voita
0.5 tl paprikaa
muutama tippa viinietikkaa
0.25 tl jauhettua garam masalaa
suolaa
40 g kermaa$q$, $q$Valuta jogurtti kahvinsuodattimessa. Soseuta valkosipuli ja inkivääri tehosekoittimessa. Sekoita tämä sose, mausteet, suola ja limettimehu jogurtin kanssa marinadia varten.

Kuori tomaatit ryöppäämällä kastiketta varten. Soseuta haarukalla tai survimella. Hienonna sarviapilan lehdet jauheeksi.

Tee luisiin paloihin viiltoja, marinoi broilerinpaloja jogurttiseoksessa vähäintään tunti, mieleemmin pari tai yön yli viileässä.

Kuumenna öljy isossa, paksupohjaisessa pannussa ja lisää broilerinpalat marinointiliemineen. Hauduta kypsäksi miedolla lämmöllä. Kääntele broilerinpaloja silloin tällöin.

Paista tomaatteja paistinpannussa 5 minuuttia.

Lisää voi ja paprika. Anna voin kiehua hiljalleen minuutin ajan. Maista happamuus. Lisää muutama tippa viinietikkaa, ellei seos maistu happamalta. Lisää sarviapila- ja garam masla-jauhe sekä suolaa tarvittaessa. Sekoita kerma joukkoon 30 sekunnin kuluttua. Lisää valmsi kastike pannuun ja sekoita broilerinpalojen kanssa. Tarjoa heti.

Broilerin voi kypsentää jo aiemminkin. Tomaatinkin voi kypsentää etukäteen, mutta voi lisätään ja kastike valmistetaan juuri ennen tarjoilua.$q$, $q$4 annosta$q$),
($q$wokki$q$, $q$Wokki$q$, $q$kastike:
        0.5 dl soijakastiketta
        0.6 dl kiinalaista kalakastiketta
	2 tl inkivääriä
	2 tl chilitahnaa (srirachaa)

öljyä
porkkanaa ohuina suikaleina
sipulia suikaleina
valkosipulia ohuina siivuina
pavunpalkoja kiehautettuna
kukkakaalia keitettynä
parsakaalia keitettynä
300 g suikaloitua kanan, naudan tai porsaanlihaa$q$, $q$Paistetaan raaka-aineet yksi kerrallaan öljy-kalakastike-mausteseoksessa, lopuksi sekoitetaan kaikki ainekset yhteen.$q$, $q$Yksinkertaisuudessaan loistavaa 'pikaruokaa'. 
Varioda voi helposti omien mieltymyksiensä sekä kausiluontoisesti raaka-aineiden saatavuuden mukaan$q$);

INSERT INTO recipes (id, title, ingredients, instructions, info) VALUES
($q$cassoulet$q$, $q$Cassoulet$q$, $q$330 g valkoisia papuja
300 g lammasta
300 g possua
2 valkosipulimakkaraa
2 valkosipulinkynttä
1 sipuli
1 porkkana
maustenippu/yrttejä
suolaa
pippuria
400 g tomaattimurskaa
korppujauhoja$q$, $q$Liota pavut ja keitä maustenipun, sipulin ja porkkanan kanssa noin 1,5 tuntia. Freesaa lihat, lisää suola ja pippuri, pieni sipuli ja valkosipuli. Lisää papujen keitinlientä, tomaattia ja maustenippu ja keitä noin 1,5 tuntia. Laita lihat ja kastike vuoan pohjalle, pavut sekä siivutetut makkarat päälle. Lisää tarvittaessa lientä, ripottele korppujauhot pinnalle ja gratinoi 175 °C:ssa noin tunti.$q$, NULL),
($q$paputahna$q$, $q$Paputahna$q$, $q$Purkki kidneypapuja liemineen
Jeeraa
Srirachaa
Suolaa
(omena)viinietikkaa$q$, $q$Muserra pavut pannulle oliiviöljyyn, lisää mausteet ja keitä kasaan.$q$, NULL),
($q$intialaiset-mustasilmapavut$q$, $q$Intialaiset mustasilmäpavut$q$, $q$250 g papuja
1 sipuli
400 g tomaattimurskaa
3 valkosipulinkynttä
Srirachaa
Kanelia
Jeeraa
Korianteria
Kurkumaa
9 dl kuumaa vettä$q$, $q$Freesaa jeera öljyssä sipulit, lisää tomaattimurska ja muut mausteet paitsi korianteri. Lisää pavut ja vesi. Hauduta kunnes pavut ovat kypsiä ja lisää vettä tarvittaessa. Lisää lopuksi korianteri. Tarjoile jalapenojen kera.$q$, NULL),
($q$kanarintafilepihvit$q$, $q$Kanarintafilepihvit$q$, $q$Kananrintafileitä
Oliiviöljyä paistamiseen
Kananmunaa
Korppujauhoja leivitykseen
Shalottisipulia
Valkosipulia
Kirsikkatomaatteja
Tuoretta basilikaa
Mozzarellaa
Parmesaania
Viinisuolaheinää$q$, $q$Halkaise kananrinnat perhosiksi ja leivitä muna- ja korppujauhokerroksilla. Paista oliiviöljyssä kypsiksi. Paista shalotit, valkosipuli ja kirsikkatomaatit, lisää basilika. Lusikoi seos kanojen päälle, lisää mozzarella ja parmesaani ja käytä uunissa noin 8 minuuttia. Tarjoa viinisuolaheinän ja halutessasi paistettujen perunoiden kanssa.$q$, NULL),
($q$kurkkuraita$q$, $q$Kurkkuraita$q$, $q$10 cm tuoretta kurkkua, hienonnettuna
2,5 dl maustamatonta jogurttia
Suolaa
Pippuria
Paprikaa
Jeeraa$q$, $q$Sekoita kaikki aineet keskenään. Kurkku kuoritaan ja hienonnetaan jogurttiin.$q$, NULL),
($q$tomaattisilli$q$, $q$Tomaattisilli – Fammun resepti$q$, $q$4 nahatonta sillifilettä
2 sipulia
Etikkakurkun paloja
3 dl tomaattisosetta
0,5 dl sokeria
1 dl etikkakurkun lientä
Tilliä
Mustapippuria
Laakerinlehti$q$, $q$Valmista sillistä, sipulista, etikkakurkuista ja maustetusta tomaattiseoksesta silliruoka ja anna maustua jääkaapissa.$q$, NULL),
($q$siankylki-uunissa$q$, $q$Siankylki uunissa$q$, $q$1–1,5 kg siankylkeä
Rosmariinia
Fenkolinsiemeniä
Jeeraa
Cayennepippuria
Mustapippuria
Suolaa
Kastike: 1/2 sipuli, porkkana, sellerinvarsi, 0,5 dl punaviiniä$q$, $q$Poista nahka ja ruuduta läskipinta. Jauha siemenet ja sekoita mausteet, hiero kylkeen. Peitä vuoka foliolla ja paista 150 °C:ssa noin 1,5 tuntia. Poista folio ja jatka 200 °C:ssa noin puoli tuntia. Kastiketta varten hauduta sipuli, porkkana ja selleri vuoan pohjalla, pyreytä nesteen kanssa ja lisää punaviiniä.$q$, NULL),
($q$pork-belly$q$, $q$Pork Belly$q$, $q$0,7–1,5 kg sian vatsaa tai kylkeä ilman luita
Suolaliemi: 2 l vettä, 100 g suolaa
Optio: 1 tl paprikajauhetta, 1/2 tl sipulijauhetta, 1/2 tl jeeraa$q$, $q$Suolaa liha liemessä yön yli. Valuta, kaada kiehuvaa vettä nahan päälle, kuivaa ja suolaa nahka. Paista tiiviissä vuoassa 140 °C:ssa 2,5–3 tuntia. Nosta lämpö 240 °C:een ja anna nahan kuplia 20–30 minuuttia vahtien ruskistumista. Tarjoa perunoiden tai ranskalaisten kanssa; paistoliemestä voi tehdä kastikkeen.$q$, NULL),
($q$beans-bacon$q$, $q$Beans & Bacon$q$, $q$1 kg valkoisia papuja
1 kg siankylkeä
2 sipulia
2 porkkanaa
2 valkosipulinkynttä
400 g tomaattimurskaa
Yrttejä, esim. timjamia$q$, $q$Keitä liotetut pavut pehmeiksi. Paista lihat padassa ja siirrä sivuun. Paista sipuli, porkkana ja valkosipuli, lisää tomaattimurska ja mausteet. Lisää pavut ja liha sekä tarvittaessa lientä. Peitä pekonisiivuilla ja hauduta uunissa noin 1,5 tuntia; ruskista pekoni lopuksi.$q$, NULL),
($q$kefta-kebab$q$, $q$Kefta Kebab$q$, $q$500 g naudan jauhelihaa
1 pieni sipuli
0,25 tl maustepippuria
0,5 tl paprikaa
2 rkl persiljaa
Pieni ripaus cayennea
Oliiviöljyä
Korianteria
Mustapippuria
0,5 tl jeeraa$q$, $q$Jauha aineet tahnaksi, muotoile tangoiksi ja paista tai grillaa. Uunissa noin 250 °C:ssa noin 5 minuuttia.$q$, NULL),
($q$aioli$q$, $q$Aioli$q$, $q$2,5 dl öljyä
2 keltuaista
1 rkl sitruunamehua
4 valkosipulinkynttä
Pippuria
Suolaa$q$, $q$Vatkaa keltuaiset. Lisää öljy ensin tipoittain voimakkaasti vatkaten ja myöhemmin ohuena nauhana. Mausta sitruunamehulla, pippurilla ja suolalla. Purista valkosipuli joukkoon.$q$, NULL),
($q$currymajoneesi$q$, $q$Currymajoneesi$q$, $q$Majoneesia (ei kevyt)
Madras-curryjauhetta$q$, $q$Sekoita curryjauhe majoneesiin.$q$, NULL),
($q$piparjuurimajoneesi$q$, $q$Piparjuurimajoneesi$q$, $q$Majoneesia
Raastettua piparjuurta tai piparjuuritahnaa
Suolaa ja pippuria
Tilkka sitruunamehua$q$, $q$Sekoita ainekset. Tarjoa kalan tai keitetyn lihan kanssa.$q$, NULL),
($q$valkosipulivoi$q$, $q$Valkosipulivoi$q$, $q$50 g voita
1 iso valkosipulinkynsi
1 tl soijakastiketta$q$, $q$Sekoita hieman sulaan voihin murskattu valkosipuli ja soijakastike.$q$, NULL),
($q$chilivoi$q$, $q$Chilivoi$q$, $q$50 g voita
2–5 tl srirachaa
(1 valkosipulinkynsi)$q$, $q$Sekoita sriracha hieman sulaneeseen voihin ja tarjoile.$q$, NULL),
($q$purjokeitto$q$, $q$Purjokeitto$q$, $q$250 g purjon valkoista osaa
0,5 l kanalientä
0,5–1 dl kermaa
1–2 rkl voita
Suolaa
Cayennepippuria
Limemehua
(crème fraiche)
(pekoni)
(ruohosipuli)$q$, $q$Viipaloi purjo ja keitä liemessä noin 20 minuuttia. Soseuta, palauta kattilaan ja lisää kerma sekä voi. Mausta suolalla, cayennella ja limemehulla. Tarjoa sellaisenaan tai crème fraichen, pekonin ja ruohosipulin kanssa.$q$, NULL),
($q$tomaatti-sipulisalaatti$q$, $q$Tomaatti-sipulisalaatti$q$, $q$2 kypsää terttutomaattia
1 isohko keltasipuli
Balsamicoa
Oliiviöljyä
Maldon-suolaa
Mustapippuria$q$, $q$Viipaloi tomaatit ja sipuli. Sekoita vinaigrette-ainekset ja kaada salaatin päälle. Sipulin voi marinoida ensin balsamicossa.$q$, NULL),
($q$kasvissalaatti$q$, $q$Kasvissalaatti$q$, $q$350 g munakoisoa
0,5 dl oliiviöljyä
1 sipuli
350 g kesäkurpitsaa
1 punainen paprika
1 vihreä paprika
1 keltainen paprika
3 tomaattia
1 rkl basilikaa
1 rkl persiljaa
Suolaa
Pippuria$q$, $q$Itketä munakoiso suolalla ja huuhtele. Hauduta sipuli ja munakoiso öljyssä, lisää kesäkurpitsa ja paprikat ja hauduta noin 15 minuuttia. Sekoita joukkoon tomaatit, basilika ja persilja. Tarjoa lämpimänä tai kylmänä.$q$, NULL),
($q$bratwurst$q$, $q$Bratwurst$q$, $q$3 bratwurst-makkaraa
2 kananmunaa
1 keltasipuli$q$, $q$Paista bratwurstit voissa ruskeiksi. Kuullota sipuli pehmeäksi. Paista kananmunat vain toiselta puolelta ja tarjoa sipulin päällä.$q$, NULL),
($q$guacamole$q$, $q$Guacamole$q$, $q$2 kypsää avokadoa
2 rkl sitruunamehua
1 valkosipulinkynsi
2 kuorittua tomaattia
1 tuore vihreä maustepaprika
1 rkl tuoretta korianteria tai persiljaa
Suolaa
Pippuria$q$, $q$Soseuta avokadot sitruunamehun kanssa. Lisää valkosipuli, tomaatit, sipuli, paprika, yrtit, suola ja pippuri. Sekoita ja tarjoa heti.$q$, NULL),
($q$omeletti$q$, $q$Omeletti$q$, $q$5 kananmunaa
3 rkl ruokakermaa
Suolaa
Pippuria
Ruohosipulia
2 tomaattia
100 g savukinkkua$q$, $q$Vatkaa munat ja kerma, mausta. Paista voissa kunnes seos kiinteytyy. Asettele tomaatti- ja kinkkuviipaleet päälle ja taita omeletti.$q$, NULL),
($q$lämmin-possunposki-salaatti$q$, $q$Lämmin possunposki-salaatti$q$, $q$1 kg keitettyjä possunposkia
Rucolaa
Tuoretta persiljaa
Suolakurkkua
Kaprista
Kastike: oliiviöljyä, 1 tl Dijon-sinappia, 1 rkl hunajaa, 2–3 rkl valkoviinietikkaa, 1 tl valkosipulijauhetta, suolaa, pippuria$q$, $q$Sekoita kastike ja salaattiainekset. Tarjoa salaatti lämpimien, pannulla voissa ruskistettujen possunposkien kanssa.$q$, NULL),
($q$luuydin-persiljasalaatti$q$, $q$Luuydin ja persiljasalaatti$q$, $q$12 kpl 7–8 cm vasikan luuydintä
Kourallinen persiljaa
2 shalottisipulia
Kourallinen kapriksia
Kastike: sitruunamehua, neitsytoliiviöljyä, merisuolaa, pippuria$q$, $q$Paista luuytimet kuumassa uunissa noin 20 minuuttia. Hienonna persilja, shalotit ja kaprikset, sekoita kastike ja kaada salaatin päälle. Tarjoa luuytimet heti.$q$, NULL),
($q$juuriselleripyree$q$, $q$Juuriselleripyree$q$, $q$600 g kuorittua juuriselleriä
0,5–1 dl ruokakermaa
Sitruunamehua
Suolaa
Pippuria$q$, $q$Keitä selleri sitruunalla ja suolalla maustetussa vedessä pehmeäksi. Soseuta, lisää kerma ja mausteet. Tarjoa perunamuusin asemesta.$q$, NULL),
($q$tuoreet-herneen-versot$q$, $q$Tuoreet herneen versot$q$, $q$Kuivattuja herneitä
Laakea astia
Multaa tai talouspaperia$q$, $q$Liota herneitä yön yli. Istuta seuraavana päivänä kosteaan multaan tai talouspaperille. Pidä kosteana ja kasvata lämpimässä ja valoisassa noin viisi päivää. Korjaa versot alle 10 cm pituisina.$q$, NULL),
($q$fammun-hernekeitto$q$, $q$Fammun hernekeitto$q$, $q$500 g kuivattuja herneitä
500 g savupotkaa tai savukinkkua
Suolaa
(lihaliemikuutio)
(tuoretta sipulia)$q$, $q$Liota herneitä yön yli. Keitä herneet ja savupotka, kunnes liha irtoaa luusta ja herneet ovat pehmeitä. Irrota liha, hienonna ja lisää keittoon. Tarjoa sipulisilpun tai sinapin kanssa.$q$, NULL),
($q$suolaliha$q$, $q$Suolaliha$q$, $q$300 g naudan sisäpaistia tai filettä
1 dl sokeria
1 dl suolaa
6–8 katajanmarjaa
2 laakerinlehteä
2 tl timjamia$q$, $q$Sekoita suola, sokeri ja mausteet. Kääri noin 3 cm paksuiset lihaviipaleet seokseen tiiviisti kelmuun ja anna maustua jääkaapissa 2–3 vuorokautta käännellen. Huuhtele ja tarjoa ohuina viipaleina.$q$, NULL),
($q$minuuttipihvi$q$, $q$Minuuttipihvi$q$, $q$200 g naudan sisäpaistia ruokailijaa kohden
150 g keräkaalia ruokailijaa kohden
0,5 sipulia
Pepperonia tai jalapenoa
Suolakurkkua$q$, $q$Nuiji paisti enintään 5 mm paksuksi. Mausta ja ruskista voissa täydellä teholla valurautapannulla. Paista noin 30 sekuntia per puoli. Pannun voi deglaseerata kastikepohjaksi.$q$, NULL),
($q$broccoligratiini$q$, $q$Broccoligratiini$q$, $q$Parsakaalia
Paksua juustokastiketta
Halutessa parmesaania$q$, $q$Keitä parsakaalin varret ja kukinnot 5–6 minuuttia ja valuta. Laita vuokaan, kaada paksu juustokastike päälle ja gratinoi grillivastuksella noin 20 minuuttia. Halutessa lisää parmesaania.$q$, NULL),
($q$currywurst$q$, $q$Currywurst$q$, $q$2 bratwurstia
Paprikajauhetta
Madras-currya
Ketsuppia
Öljyä paistamiseen$q$, $q$Pilko ja paista bratwurstit. Mausta paprikalla ja currylla ja sekoita joukkoon ketsuppi. Kuumenna ja tarjoa.$q$, NULL),
($q$bifteck-hache$q$, $q$Bifteck Haché – jauhelihapihvi$q$, $q$Perus: 800 g naudan jauhelihaa, 1 keskikokoinen keltasipuli, suolaa, pippuria.
Variaatioita: vasikanfondi, ketsuppi/tomaattipyree, timjami, basilika, oregano, BBQ-kastike, savuaromi, jeera, korianteri, sriracha, currytahna, limemehu, kalakastike, kardemumma, inkivääri, valkosipuli, chili, soija.$q$, $q$Silppua sipuli erittäin hienoksi ja sekoita jauhelihan sekä mausteiden kanssa. Muotoile neljä noin 1,5 cm paksuista pihviä ja paista kuumalla pannulla voissa, esimerkiksi 2 minuuttia per puoli. Reseptissä esitellään useita yrtti-, BBQ-, meksikolais-, thai-, intialais- ja chilivariaatioita samalla perusperiaatteella.$q$, NULL),
($q$thai-maustevoi$q$, $q$Thai-tyylinen maustevoi tai majoneesi$q$, $q$1 dl majoneesia tai voita
2–3 tl punaista tai vihreää currytahnaa$q$, $q$Sekoita currytahna majoneesiin tai pehmeään voihin.$q$, NULL),
($q$thaimaalainen-salaatti$q$, $q$Thaimaalainen salaatti$q$, $q$3 valkosipulinkynttä
3 cm inkivääriä
1 pieni jäävuorisalaatti
2 tomaattia
1 keskikokoinen kurkku
1 sipuli
Kastike: 2 rkl kalakastiketta, 2 rkl limemehua, 1 rkl soijaa, 1 chili, 2 rkl öljyä$q$, $q$Sekoita kastike ja anna tekeytyä. Revi salaatti, kuutioi tomaatti ja kurkku, viipaloi sipuli. Lisää valkosipuli ja inkivääri, kaada kastike päälle ja anna maustua.$q$, NULL),
($q$juuriselleri-piparjuurimuusi$q$, $q$Juuriselleri ja piparjuuri -muusi$q$, $q$n. 400 g juuriselleriä
1–2 tl piparjuuritahnaa tai raastettua piparjuurta
n. 50 g voita
Suolaa
Pippuria$q$, $q$Keitä sellerikuutiot sitruunamehulla maustetussa vedessä pehmeiksi. Valuta ja muussaa voin, piparjuuren ja mausteiden kanssa.$q$, NULL),
($q$sianliha-noisetit$q$, $q$Sianliha-noisetit kermakastikkeella linssien kera$q$, $q$Liha: 800 g sian sisä- tai ulkofilettä, 1 dl soijaa, 1 tl–1 rkl inkivääriä, 1 tl–1 rkl srirachaa.
Linssit: 2–3 dl vihreitä linssejä.
Kastike: n. 2 dl kermaa, n. 1 tl vasikanfondia, suolaa, pippuria.$q$, $q$Marinoi lihapalat soija-inkivääri-chilimarinaadissa vähintään tunti. Paista pannulla noin 4 minuuttia per puoli ja kypsennä loppuun uunissa noin 70 °C sisälämpöön. Keitä linssit. Deglaseeraa pannu kermalla, lisää marinadin rippeet ja fondi ja keitä kastikkeeksi. Tarjoa noisetit kastikkeen ja linssien kanssa.$q$, NULL),
($q$porkkanapyree$q$, $q$Porkkanapyree$q$, $q$400 g kuorittuja porkkanoita
Voita
2 jauhettua tähtianista
1/2 tl kuivattua rakuunaa
500 ml kanalientä
Tilkka kermaa
Tilkka limemehua
Suolaa ja pippuria$q$, $q$Freesaa tähtianis ja rakuuna voissa. Lisää porkkanat ja paista hetki. Lisää liemi ja keitä pehmeäksi. Soseuta osan liemestä kanssa, lisää kerma ja lime ja mausta.$q$, NULL),
($q$cafe-du-paris-voi$q$, $q$Café de Paris -voi$q$, $q$0,5 kg voita
4 tl ketsuppia
4 tl Dijon-sinappia
2 tl kapriksia
2 rkl shalottia
1 rkl persiljaa
2 rkl ruohosipulia
2 rkl basilikaa
1 tl rakuunaa
Rosmariinia
1 valkosipulinkynsi
4 anjovisfilettä
1 tl Worcestershire-kastiketta
1/2 tl makeaa paprikaa
1/2 tl Madras-currya
Cayennea
Sitruunamehua$q$, $q$Sekoita mausteainekset pehmeään voihin tasaiseksi maustevoiksi.$q$, NULL),
($q$kheema$q$, $q$Kheema$q$, $q$4 rkl öljyä
2 keskikokoista sipulia
500 g naudan jauhelihaa
2 rkl inkivääri-valkosipulitahnaa
1 tl punaista chilijauhetta
1 tl kurkumaa
2 tl korianterijauhetta
1 tl suolaa
4 tomaattia
1/2 cup tuoretta korianteria
1/4 cup tuoretta minttua
2 birds eye -chiliä
1 rkl voita (valinnainen)
1 tl kuivattua sarviapilaa (valinnainen)$q$, NULL, NULL),
($q$lasagne$q$, $q$Lasagne$q$, $q$Bolognese: 400 g naudan jauhelihaa, tomaattimurskaa/paseeta, sipuli, porkkana, selleri, valkosipuli, korianteri, timjami, sriracha, MSG, punaviini, savuaromi, öljy, suola, pippuri.
Bechamel: 1 l maitoa, 1,1 dl jauhoa, 2 tl muskottipähkinää, rypsiöljyä, suolaa, pippuria.
Lisäksi lasagnelevyjä ja parmesaania.$q$, $q$Valmista bolognese ja bechamel. Ota noin 7 kauhallista bechamelia erikseen ja sekoita loput bolognesen kanssa. Kokoa vuokaan vuorotellen kastiketta ja levyjä, viimeistele erikseen otetulla bechamelilla ja parmesaanilla. Paista 200 °C:ssa 40–45 minuuttia.$q$, NULL),
($q$pika-bolognese$q$, $q$Pika Bolognese neljälle$q$, $q$400 g sikanautaa
Tomaattimurskaa tai paseeta
Pieni sipuli
Valkosipulia
2 tl sellerisuolaa
2 tl korianterijauhetta
1 tl srirachaa
2 tl timjamia
1 tl MSG:tä
2 tl punaviinietikkaa
Savuaromia
Ruokosokeria
Suolaa
Pippuria$q$, $q$Pyreytä tomaatti. Kuullota sipuli, lisää jauheliha ja mausteet ja ruskista. Lisää tomaatti, timjami, viinietikka ja savuaromi ja hauduta. Lisää keitetty pasta ja sekoita, kunnes kastike imeytyy.$q$, NULL),
($q$ranskalaiset-linssit$q$, $q$Ranskalaiset linssit$q$, $q$1,5 dl Puyn tai vihreitä linssejä
4,5 dl vettä
1 kanaliemikuutio/fondi
Salottisipuli
Sipulia
1 porkkana
1 sellerinvarsi
1 tl kuivattua timjamia
1 laakerinlehti
Oliiviöljyä ja voita$q$, $q$Freesaa sipuli, lisää vihannekset, linssit, timjami ja laakerinlehti. Lisää vesi ja liemi ja hauduta kannen alla noin 30–40 minuuttia, kunnes linssit ovat pehmeitä ja neste imeytynyt.$q$, NULL),
($q$sauce-espagnole$q$, $q$Sauce Espagnole – pika versio$q$, $q$1 lihaliemikuutio
1/2 kasvisliemikuutio
0,25 dl vehnäjauhoa
1 rkl tomaattipyreetä
1/2 tl sokeria
2,5 dl vettä
Öljyä tai voita$q$, $q$Kiehauta vesi. Ruskista jauho rasvassa vähintään piparkakun väriseksi. Kaada vesi sekaan voimakkaasti sekoittaen. Lisää muut ainekset ja kiehuta 5–10 minuuttia.$q$, NULL),
($q$parsa-pasta$q$, $q$Parsapasta$q$, $q$Nippu parsaa
300 g pastaa
2 dl kermaa
1/2 tl minttua
1 pieni sipuli$q$, $q$Kuori parsa ja hienonna sipuli. Keitä parsa suolavedessä noin 4 minuuttia ja nosta pois. Keitä pasta. Kuullota sipuli, lisää kerma ja minttu sekä parsa ja sekoita kastike pastaan.$q$, NULL),
($q$paahdetut-perunakiekot$q$, $q$Paahdetut perunakiekot$q$, $q$1 kg kiinteää perunaa
Oliivi- tai rypsiöljyä
Timjamia
Sipulijauhetta
Valkosipulijauhetta
Suolaa
(MSG:tä)$q$, $q$Viipaloi perunat 8–10 mm kiekoiksi. Keitä 2 % suolavedessä 12 minuuttia ja kuivata höyryssä. Sekoita öljy ja mausteet joukkoon. Paahda grillivastuksen alla 225 °C:ssa noin puoli tuntia, kunnes ruskistuvat.$q$, NULL),
($q$eekun-tomaattikastike$q$, $q$Eekun tomaattikastike$q$, $q$Purkki tomaattimurskaa
Viinietikkaa
Suolaa
Sokeria
Pippuria
Sellerisuolaa
Oreganoa
Basilikaa
Srirachaa
Chilirouhetta$q$, $q$Yhdistä aineet ja pyreytä tarvittaessa. Tarkista maku ja säädä.$q$, NULL),
($q$killan-silli$q$, $q$Killan silli$q$, $q$Silliä
Sipulia
Punajuurta
Maustekurkkua
Kastike: sinappia, sokeria ja rypsiöljyä$q$, $q$Sekoita sinapista, sokerista ja öljystä kastike. Tarjoa sillin kanssa sipuli-, punajuuri- ja maustekurkkusilppua sekä keitettyä perunaa ja kananmunaa.$q$, NULL),
($q$lihasoppa$q$, $q$Lihasoppa$q$, $q$1–1,5 kg häränhäntiä tai n. 700 g rasvaista naudan etuselkää
1,5 kg perunaa
0,5 kg porkkanoita
Purjoa
n. 10 maustepippuria
2 laakerinlehteä
Suolaa$q$, $q$Kypsennä liha painekattilassa noin 2 tuntia. Irrota liha ja lisää kuutioidut perunat ja porkkanat liemeen. Lisää tarvittaessa vettä ja kypsennä vielä noin 30 minuuttia. Irrota liha luista ja lisää takaisin. Mausta ja tarjoa lipstikan sekä ruis- tai näkkileivän kanssa.$q$, NULL),
($q$birds-of-prey-sandwich$q$, $q$Birds of Prey sandwich$q$, $q$Paketti pekonia
2 viipaletta cheddar-tyyppistä juustoa
2 kananmunaa
2 viipaletta paahtoleipää/ranskanleipää/sämpylää
Majoneesia
Piri-piri- tai muuta hot saucea$q$, $q$Paista pekoni. Ruskista leipä pekonirasvassa ja voitele majoneesilla. Paista kananmunat molemmin puolin. Kokoa leipä munasta, juustosta, hot saucesta ja pekonista.$q$, NULL),
($q$mac-and-cheese$q$, $q$Mac & cheese$q$, $q$1 l maitoa
1,1 dl jauhoa
250 g cheddar-raastetta
1/2 raastettu sipuli
300 g makaronia
1 tl muskottipähkinää
1/2 tl cayennea
1/2 tl sinappijauhoa
1 tl Worcestershire-kastiketta
Öljyä
Suolaa
Pippuria$q$, $q$Valmista bechamel öljystä, jauhosta ja maidosta. Lisää mausteet. Ota pois lämmöltä ja sekoita sipuli sekä juustoraaste joukkoon. Keitä makaroni hieman alle suositusajan, sekoita kastikkeeseen ja siirrä vuokaan. Lisää korppujauhoa ja paista 190 °C:ssa noin 30 minuuttia.$q$, NULL),
($q$gong-bao-kana$q$, $q$Gong bao kanaa$q$, $q$Wokki: 350 g kanaa, valkosipulia, inkivääriä, purjoa, chilihiutaleita, öljyä, 100 g maapähkinöitä, Sichuan-pippuria, paprikaa.
Marinadi: suolaa, 4 tl soijaa, 1 tl valkoviiniä, 1,5 tl peruna- tai maissijauhoa.
Kastike: 1 rkl sokeria, 1 tl peruna- tai maissijauhoa, 4 tl soijaa, 1 rkl balsamicoa, 1 tl seesamiöljyä, 1 rkl kanalientä/vettä.$q$, $q$Marinoi kana. Sekoita kastike. Kuumenna öljy ja Sichuan-pippurit, wokkaa kana, lisää vihannekset ja kypsennä. Lisää kastike ja kuumenna sakeaksi. Lisää lopuksi pähkinät. Tarjoa riisin tai nuudeleiden kanssa.$q$, NULL),
($q$sechuan-style-pork$q$, $q$Sechuan style pork$q$, $q$Sianliha ja marinadi: 450–500 g sianlihaa, 1 rkl soijaa, 1 rkl valkoviiniä, 1 tl maizenaa.
Kastike: 2 rkl soijaa, 2 rkl hoisin- tai osterikastiketta, 1 rkl valkoviinietikkaa, 2 tl sokeria, 1 tl seesamiöljyä, 1 tl maizenaa, 1–2 rkl paahdettua Sichuan-pippuria, 1 tl chilihiutaleita.
Wokki: öljyä, sipuli, 2 paprikaa, 3 valkosipulinkynttä, inkivääriä, 1/2 dl kanalientä.$q$, $q$Marinoi liha. Sekoita kastike. Wokkaa liha ja siirrä sivuun. Paista inkivääri ja valkosipuli, lisää sipuli ja paprikat. Lisää kanaliemi ja liha, sitten kastike. Wokkaa kunnes kastike sakenee ja tarttuu aineksiin. Tarjoa riisin kanssa.$q$, NULL),
($q$shawarma$q$, $q$Shawarma$q$, $q$750 g kanan reisilihoja
1 sipuli
Marinadi: 2 valkosipulinkynttä, 1/2 sitruunan mehu ja kuori, 4 rkl öljyä, 2 tl jeeraa, 2 tl paprikajauhetta, 1 tl kanelia, 1/2 tl neilikkaa, 1/2 tl kardemummaa, 1/2 tl cayennea, 1 tl kurkumaa, 1 tl suolaa$q$, $q$Sekoita marinadi tahnaksi ja hiero kanaan. Lisää sipuli ja marinoi yön yli. Paista valurautapannulla tai grillaa ja siivuta. Tarjoa aiolin/tsatsikin, kebabkastikkeen, sipulin ja tomaatin kanssa sekä keltaisen riisin, pitan tai tortillan kanssa.$q$, NULL),
($q$grillattu-salaattisikuri$q$, $q$Grillattu salaattisikuri$q$, $q$1–2 salaattisikuria
Kirsikkatomaatteja
Parmesanlastuja
Balsamicoreduktiota
Maggi Aromea
Oliiviöljyä
Suolaa
Pippuria$q$, $q$Halkaise sikuri ja tomaatit. Mausta sikuri Maggi Aromella, öljyllä, suolalla ja sokerilla. Grillaa tai paista sikurit ja tomaatit, noin 5 minuuttia per puoli. Tarjoa sellaisenaan tai pihvin lisukkeena.$q$, NULL),
($q$salsakastike$q$, $q$Salsakastike$q$, $q$400 g tomaattimurskaa tai -paseeta
Suolaa
Pippuria
2–3 valkosipulinkynttä
Kuminaa
Korianteria
0,5 rkl viinietikkaa
Srirachaa
(oreganoa)
1 iso sipuli hienoksi silputtuna$q$, $q$Valmista kuten tomaattikastike, mutta lisää hyvin hienoksi silputtu sipuli.$q$, NULL),
($q$siipikastike$q$, $q$Siipikastike$q$, $q$2/3 cup hot pepper saucea
1/2 cup suolatonta voita
1,5 rkl valkoviinietikkaa
1/4 tl Worcestershire-kastiketta
1/4 tl cayennepippuria
1/8 tl valkosipulijauhetta
Suolaa$q$, $q$Sulata voi ja sekoita siihen hot sauce, etikka ja mausteet. Kuumenna tasaiseksi ja sekoita kypsien siipien joukkoon.$q$, NULL)
ON CONFLICT (id) DO NOTHING;

ALTER TABLE recipe_tags
    ADD CONSTRAINT recipe_tags_allowed_tag
    CHECK (tag IN (
        'pääruoka',
        'lisuke',
        'jälkiruoka',
        'keitto',
        'kana',
        'ankka',
        'nauta',
        'kala',
        'jauheliha',
        'lammas',
        'sika',
        'kasvis',
        'kastike',
        'marinadi',
        'essee'
    ));

INSERT INTO recipe_tags (recipe_id, tag) VALUES
($q$Pippurikerma-kastike$q$, $q$kastike$q$),
($q$ankanrinnat$q$, $q$pääruoka$q$),
($q$ankanrinnat$q$, $q$ankka$q$),
($q$avokadopasta$q$, $q$pääruoka$q$),
($q$avokadopasta$q$, $q$kana$q$),
($q$balmoral-kastike$q$, $q$kastike$q$),
($q$balti-ghost$q$, $q$pääruoka$q$),
($q$balti-ghost$q$, $q$lammas$q$),
($q$bechamel-kastike$q$, $q$kastike$q$),
($q$bolognese-kastike$q$, $q$pääruoka$q$),
($q$bolognese-kastike$q$, $q$jauheliha$q$),
($q$bolognese-kastike$q$, $q$nauta$q$),
($q$broccoli-paistos$q$, $q$lisuke$q$),
($q$broccoli-paistos$q$, $q$kasvis$q$),
($q$broccoli-paistos$q$, $q$sika$q$),
($q$chalupa$q$, $q$lisuke$q$),
($q$chicken-tikka-masala$q$, $q$pääruoka$q$),
($q$chicken-tikka-masala$q$, $q$kana$q$),
($q$chickenwings$q$, $q$pääruoka$q$),
($q$chickenwings$q$, $q$kana$q$),
($q$chili-con-carne$q$, $q$pääruoka$q$),
($q$chili-con-carne$q$, $q$jauheliha$q$),
($q$chili-con-carne$q$, $q$nauta$q$),
($q$chimichurri$q$, $q$marinadi$q$),
($q$coleslaw$q$, $q$lisuke$q$),
($q$coleslaw$q$, $q$kasvis$q$),
($q$curry-pasta$q$, $q$pääruoka$q$),
($q$curry-pasta$q$, $q$kana$q$),
($q$eren-tomaattikastike$q$, $q$kastike$q$),
($q$fenkoligratiini$q$, $q$lisuke$q$),
($q$fenkoligratiini$q$, $q$kasvis$q$),
($q$grillattu-lohi$q$, $q$pääruoka$q$),
($q$grillattu-lohi$q$, $q$kala$q$),
($q$grillimarinadi-kanalle$q$, $q$marinadi$q$),
($q$grillimarinadi-kanalle$q$, $q$kana$q$),
($q$grillioljy$q$, $q$marinadi$q$),
($q$hapanjuuri-patonki$q$, $q$lisuke$q$),
($q$juustokastike$q$, $q$kastike$q$),
($q$kana-avokado-salaatti$q$, $q$lisuke$q$),
($q$kana-avokado-salaatti$q$, $q$kana$q$),
($q$kana-espanjalaisittain$q$, $q$pääruoka$q$),
($q$kana-espanjalaisittain$q$, $q$kana$q$),
($q$kana-vindaloo$q$, $q$pääruoka$q$),
($q$kana-vindaloo$q$, $q$kana$q$),
($q$kanakeitto$q$, $q$keitto$q$),
($q$kanakeitto$q$, $q$kana$q$),
($q$kantarelli-keitto$q$, $q$keitto$q$),
($q$kantarelli-keitto$q$, $q$kasvis$q$),
($q$keitetyt-naudan-posket$q$, $q$pääruoka$q$),
($q$keitetyt-naudan-posket$q$, $q$nauta$q$),
($q$kermainen-jauhelihapasta$q$, $q$pääruoka$q$),
($q$kermainen-jauhelihapasta$q$, $q$jauheliha$q$),
($q$kermainen-jauhelihapasta$q$, $q$nauta$q$),
($q$kermakastike-thoughts$q$, $q$essee$q$),
($q$kotitekoinen-jaatelo$q$, $q$jälkiruoka$q$),
($q$kraavilohi$q$, $q$pääruoka$q$),
($q$kraavilohi$q$, $q$kala$q$),
($q$kreikkalainen-salaatti$q$, $q$lisuke$q$),
($q$kreikkalainen-salaatti$q$, $q$kasvis$q$),
($q$kurkuma-kanapasta$q$, $q$pääruoka$q$),
($q$kurkuma-kanapasta$q$, $q$kana$q$),
($q$laskisoosi$q$, $q$pääruoka$q$),
($q$laskisoosi$q$, $q$sika$q$),
($q$laskisoosi$q$, $q$kastike$q$),
($q$lehtipihvi$q$, $q$pääruoka$q$),
($q$lehtipihvi$q$, $q$nauta$q$),
($q$lehtipihvi$q$, $q$sika$q$),
($q$lihapullat$q$, $q$pääruoka$q$),
($q$lihapullat$q$, $q$jauheliha$q$),
($q$lihapullat$q$, $q$nauta$q$),
($q$lohikeitto$q$, $q$keitto$q$),
($q$lohikeitto$q$, $q$kala$q$),
($q$maa-artisokka-keitto$q$, $q$keitto$q$),
($q$maa-artisokka-keitto$q$, $q$kasvis$q$),
($q$mansikkavaahto$q$, $q$jälkiruoka$q$),
($q$mexican-rice$q$, $q$lisuke$q$),
($q$mexican-rice$q$, $q$kasvis$q$),
($q$munakokkeli$q$, $q$pääruoka$q$),
($q$murgh-masala$q$, $q$pääruoka$q$),
($q$murgh-masala$q$, $q$kana$q$),
($q$naudan-kieli$q$, $q$pääruoka$q$),
($q$naudan-kieli$q$, $q$nauta$q$),
($q$naudanlihaa-osterikastikkeessa$q$, $q$pääruoka$q$),
($q$naudanlihaa-osterikastikkeessa$q$, $q$nauta$q$),
($q$naudanlihaa-pinaatti-purjo$q$, $q$pääruoka$q$),
($q$naudanlihaa-pinaatti-purjo$q$, $q$nauta$q$),
($q$north-caroline-style-rub$q$, $q$marinadi$q$),
($q$paistetut-herkkusienet$q$, $q$lisuke$q$),
($q$paistetut-herkkusienet$q$, $q$kasvis$q$),
($q$paistetut-silakat$q$, $q$pääruoka$q$),
($q$paistetut-silakat$q$, $q$kala$q$),
($q$pakastetut-sinisimpukat$q$, $q$pääruoka$q$),
($q$pakastetut-sinisimpukat$q$, $q$kala$q$),
($q$paprikakana-unkarilaisittain$q$, $q$pääruoka$q$),
($q$paprikakana-unkarilaisittain$q$, $q$kana$q$),
($q$parsapasta$q$, $q$pääruoka$q$),
($q$parsapasta$q$, $q$kasvis$q$),
($q$pekoni-pasta$q$, $q$pääruoka$q$),
($q$pekoni-pasta$q$, $q$sika$q$),
($q$pellavansiemen-leipa$q$, $q$lisuke$q$),
($q$perunakiekot$q$, $q$lisuke$q$),
($q$perunakiekot$q$, $q$kasvis$q$),
($q$pinaattikeitto$q$, $q$keitto$q$),
($q$pinaattikeitto$q$, $q$kasvis$q$),
($q$piri-piri-marinadi$q$, $q$marinadi$q$),
($q$piripiri-mausteliemi$q$, $q$marinadi$q$),
($q$pork-vindaloo$q$, $q$pääruoka$q$),
($q$pork-vindaloo$q$, $q$sika$q$),
($q$possun-posket$q$, $q$pääruoka$q$),
($q$possun-posket$q$, $q$sika$q$),
($q$possun-posket-uunissa$q$, $q$pääruoka$q$),
($q$possun-posket-uunissa$q$, $q$sika$q$),
($q$possunposket-portugalilaisittain$q$, $q$pääruoka$q$),
($q$possunposket-portugalilaisittain$q$, $q$sika$q$),
($q$pulled-pork$q$, $q$pääruoka$q$),
($q$pulled-pork$q$, $q$sika$q$),
($q$pyttipannu-thoughts$q$, $q$essee$q$),
($q$ranskalainen-sipulikeitto$q$, $q$keitto$q$),
($q$ranskalainen-sipulikeitto$q$, $q$kasvis$q$),
($q$rubbeja$q$, $q$marinadi$q$),
($q$schnitzel$q$, $q$pääruoka$q$),
($q$schnitzel$q$, $q$nauta$q$),
($q$schnitzel$q$, $q$sika$q$),
($q$schnitzel$q$, $q$kana$q$),
($q$sinihomejuusto-kana$q$, $q$pääruoka$q$),
($q$sinihomejuusto-kana$q$, $q$kana$q$),
($q$sinisimpukat-valkosipuli$q$, $q$pääruoka$q$),
($q$sinisimpukat-valkosipuli$q$, $q$kala$q$),
($q$sitruunakana$q$, $q$pääruoka$q$),
($q$sitruunakana$q$, $q$kana$q$),
($q$sitruunavaahto$q$, $q$jälkiruoka$q$),
($q$sousvide-tietoa$q$, $q$essee$q$),
($q$sveitsi-fondue$q$, $q$pääruoka$q$),
($q$sveitsi-fondue$q$, $q$kasvis$q$),
($q$tafelspitz$q$, $q$pääruoka$q$),
($q$tafelspitz$q$, $q$nauta$q$),
($q$thaikeitto$q$, $q$keitto$q$),
($q$thaikeitto$q$, $q$kasvis$q$),
($q$tomaattikastike$q$, $q$kastike$q$),
($q$tournedos-chateaubriand$q$, $q$pääruoka$q$),
($q$tournedos-chateaubriand$q$, $q$nauta$q$),
($q$trivialeipa$q$, $q$pääruoka$q$),
($q$vihrea-kanacurry$q$, $q$pääruoka$q$),
($q$vihrea-kanacurry$q$, $q$kana$q$),
($q$voikananpoika$q$, $q$pääruoka$q$),
($q$voikananpoika$q$, $q$kana$q$),
($q$wokki$q$, $q$pääruoka$q$),
($q$wokki$q$, $q$nauta$q$),
($q$wokki$q$, $q$kana$q$),
($q$wokki$q$, $q$sika$q$),
($q$cassoulet$q$, $q$pääruoka$q$),
($q$cassoulet$q$, $q$lammas$q$),
($q$cassoulet$q$, $q$sika$q$),
($q$paputahna$q$, $q$lisuke$q$),
($q$paputahna$q$, $q$kasvis$q$),
($q$intialaiset-mustasilmapavut$q$, $q$pääruoka$q$),
($q$intialaiset-mustasilmapavut$q$, $q$kasvis$q$),
($q$kanarintafilepihvit$q$, $q$pääruoka$q$),
($q$kanarintafilepihvit$q$, $q$kana$q$),
($q$kurkkuraita$q$, $q$lisuke$q$),
($q$kurkkuraita$q$, $q$kasvis$q$),
($q$tomaattisilli$q$, $q$lisuke$q$),
($q$tomaattisilli$q$, $q$kala$q$),
($q$siankylki-uunissa$q$, $q$pääruoka$q$),
($q$siankylki-uunissa$q$, $q$sika$q$),
($q$pork-belly$q$, $q$pääruoka$q$),
($q$pork-belly$q$, $q$sika$q$),
($q$beans-bacon$q$, $q$pääruoka$q$),
($q$beans-bacon$q$, $q$sika$q$),
($q$kefta-kebab$q$, $q$pääruoka$q$),
($q$kefta-kebab$q$, $q$jauheliha$q$),
($q$kefta-kebab$q$, $q$nauta$q$),
($q$aioli$q$, $q$kastike$q$),
($q$currymajoneesi$q$, $q$kastike$q$),
($q$piparjuurimajoneesi$q$, $q$kastike$q$),
($q$valkosipulivoi$q$, $q$kastike$q$),
($q$chilivoi$q$, $q$kastike$q$),
($q$purjokeitto$q$, $q$keitto$q$),
($q$purjokeitto$q$, $q$kasvis$q$),
($q$tomaatti-sipulisalaatti$q$, $q$lisuke$q$),
($q$tomaatti-sipulisalaatti$q$, $q$kasvis$q$),
($q$kasvissalaatti$q$, $q$lisuke$q$),
($q$kasvissalaatti$q$, $q$kasvis$q$),
($q$bratwurst$q$, $q$pääruoka$q$),
($q$bratwurst$q$, $q$sika$q$),
($q$guacamole$q$, $q$lisuke$q$),
($q$guacamole$q$, $q$kasvis$q$),
($q$omeletti$q$, $q$pääruoka$q$),
($q$lämmin-possunposki-salaatti$q$, $q$lisuke$q$),
($q$lämmin-possunposki-salaatti$q$, $q$sika$q$),
($q$luuydin-persiljasalaatti$q$, $q$pääruoka$q$),
($q$luuydin-persiljasalaatti$q$, $q$nauta$q$),
($q$juuriselleripyree$q$, $q$lisuke$q$),
($q$juuriselleripyree$q$, $q$kasvis$q$),
($q$tuoreet-herneen-versot$q$, $q$lisuke$q$),
($q$tuoreet-herneen-versot$q$, $q$kasvis$q$),
($q$fammun-hernekeitto$q$, $q$keitto$q$),
($q$fammun-hernekeitto$q$, $q$sika$q$),
($q$suolaliha$q$, $q$pääruoka$q$),
($q$suolaliha$q$, $q$nauta$q$),
($q$minuuttipihvi$q$, $q$pääruoka$q$),
($q$minuuttipihvi$q$, $q$nauta$q$),
($q$broccoligratiini$q$, $q$lisuke$q$),
($q$broccoligratiini$q$, $q$kasvis$q$),
($q$currywurst$q$, $q$pääruoka$q$),
($q$currywurst$q$, $q$sika$q$),
($q$bifteck-hache$q$, $q$pääruoka$q$),
($q$bifteck-hache$q$, $q$jauheliha$q$),
($q$bifteck-hache$q$, $q$nauta$q$),
($q$thai-maustevoi$q$, $q$kastike$q$),
($q$thaimaalainen-salaatti$q$, $q$lisuke$q$),
($q$thaimaalainen-salaatti$q$, $q$kasvis$q$),
($q$juuriselleri-piparjuurimuusi$q$, $q$lisuke$q$),
($q$juuriselleri-piparjuurimuusi$q$, $q$kasvis$q$),
($q$sianliha-noisetit$q$, $q$pääruoka$q$),
($q$sianliha-noisetit$q$, $q$sika$q$),
($q$porkkanapyree$q$, $q$lisuke$q$),
($q$porkkanapyree$q$, $q$kasvis$q$),
($q$cafe-du-paris-voi$q$, $q$kastike$q$),
($q$kheema$q$, $q$pääruoka$q$),
($q$kheema$q$, $q$jauheliha$q$),
($q$kheema$q$, $q$nauta$q$),
($q$lasagne$q$, $q$pääruoka$q$),
($q$lasagne$q$, $q$jauheliha$q$),
($q$lasagne$q$, $q$nauta$q$),
($q$pika-bolognese$q$, $q$pääruoka$q$),
($q$pika-bolognese$q$, $q$jauheliha$q$),
($q$pika-bolognese$q$, $q$sika$q$),
($q$ranskalaiset-linssit$q$, $q$lisuke$q$),
($q$ranskalaiset-linssit$q$, $q$kasvis$q$),
($q$sauce-espagnole$q$, $q$kastike$q$),
($q$parsa-pasta$q$, $q$pääruoka$q$),
($q$parsa-pasta$q$, $q$kasvis$q$),
($q$paahdetut-perunakiekot$q$, $q$lisuke$q$),
($q$paahdetut-perunakiekot$q$, $q$kasvis$q$),
($q$eekun-tomaattikastike$q$, $q$kastike$q$),
($q$killan-silli$q$, $q$lisuke$q$),
($q$killan-silli$q$, $q$kala$q$),
($q$lihasoppa$q$, $q$keitto$q$),
($q$lihasoppa$q$, $q$nauta$q$),
($q$birds-of-prey-sandwich$q$, $q$pääruoka$q$),
($q$birds-of-prey-sandwich$q$, $q$sika$q$),
($q$mac-and-cheese$q$, $q$pääruoka$q$),
($q$mac-and-cheese$q$, $q$kasvis$q$),
($q$gong-bao-kana$q$, $q$pääruoka$q$),
($q$gong-bao-kana$q$, $q$kana$q$),
($q$sechuan-style-pork$q$, $q$pääruoka$q$),
($q$sechuan-style-pork$q$, $q$sika$q$),
($q$shawarma$q$, $q$pääruoka$q$),
($q$shawarma$q$, $q$kana$q$),
($q$grillattu-salaattisikuri$q$, $q$lisuke$q$),
($q$grillattu-salaattisikuri$q$, $q$kasvis$q$),
($q$salsakastike$q$, $q$kastike$q$),
($q$siipikastike$q$, $q$kastike$q$),
($q$siipikastike$q$, $q$kana$q$)
ON CONFLICT (recipe_id, tag) DO NOTHING;

COMMIT;
