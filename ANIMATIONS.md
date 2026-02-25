# Catalogo de Animaciones - CashbackCardsDemo

> Documento de referencia que describe cada animacion visible en los videos de referencia (`videos/media1.mp4`, `videos/media2.mov`, `videos/media3.mp4`). Incluye comparativa con el estado actual del proyecto y un manual de usuario para ejecutar cada una.

---

## Indice

| # | Animacion | Video | Estado | Pantalla |
|---|-----------|-------|--------|----------|
| A01 | Onboarding Cashback (Bottom Sheet) | media1 | **NUEVA** | CashbackView |
| A02 | Skeleton Loading + Shimmer | media1, media2 | Ya existe | CashbackView |
| A03 | Staggered Appearance (fade+slide) | media1, media2 | Ya existe | CashbackView |
| A04 | Animated Counter (numeros) | media1, media2 | Ya existe | CashbackView |
| A05 | Toast Notification | media1 | Ya existe | CashbackView |
| A06 | Brand Detail - Hero Parallax | media1 | Ya existe (parcial) | BrandDetailView |
| A07 | Brand Detail - Scroll Zoom (imagen) | media1 | **NUEVA** | BrandDetailView |
| A08 | Brand Detail - Staggered Content | media1 | Ya existe | BrandDetailView |
| A09 | Brand Search - Sheet + Staggered List | media1 | Ya existe | BrandSearchView |
| A10 | Cards List - Staggered Card Appearance | media3 | Ya existe | CardsListView |
| A11 | Cards List - Toast Promo Banner | media3 | **NUEVA** | CardsListView |
| A12 | Card Detail - Navigation Transition | media3 | Ya existe (parcial) | CardDetailView |
| A13 | Card Detail - Card Scale on Scroll | media3 | Ya existe | CardDetailView |
| A14 | Card Detail - Animated Spent Counter | media3 | Ya existe | CardDetailView |
| A15 | Card Detail - Card Flip 3D (reverso) | media3 | **NUEVA** | CardDetailView |
| A16 | Card Detail - Movements Section Reveal | media3 | Ya existe (parcial) | CardDetailView |
| A17 | Card Customize - Full Screen Cover Entry | media3 | Ya existe | CardCustomizeView |
| A18 | Card Customize - 3D Rotation on Design Switch | media3 | Ya existe (parcial) | CardCustomizeView |
| A19 | Card Customize - Card Back Preview (datos reales) | media3 | **NUEVA** | CardCustomizeView |
| A20 | Brand Grid - Image Cards con fotos reales | media1, media2 | **NUEVA** | CashbackView |

---

## Detalle de cada animacion

---

### A01 - Onboarding Cashback (Bottom Sheet)

**Video:** media1 (seg 1-4) | **Estado:** NUEVA - No existe en el proyecto

**Descripcion:**
Al entrar por primera vez a la pantalla de Cashback, aparece un bottom sheet/modal con una presentacion introductoria. Contiene:
- Parte superior: 3 tarjetas de marcas apiladas con rotacion (estilo "abanico" / fan-out), mostrando imagenes reales de productos (Zara, Vicio hamburguesa, The North Face).
- Titulo: "Cashback" en negrita grande.
- Subtitulo: "Compra mas y gasta menos: te devolvemos dinero en cada compra."
- 3 bullet points con iconos: "Ofertas de ocio, moda y viajes", "Paga con tu tarjeta CaixaBank", "Recibe tu cashback en tu cuenta".
- Boton "Continuar" oscuro al fondo.

**Animacion:**
- El sheet sube desde abajo con spring animation.
- Las 3 tarjetas superiores tienen una ligera rotacion y overlap, simulando un stack de cartas.
- Al pulsar "Continuar", el sheet baja y revela la pantalla de Cashback con su loading skeleton normal.

**Diferencia con el proyecto actual:**
El proyecto actual salta directamente a la pantalla de Cashback con skeleton loading. No hay paso de onboarding.

---

### A02 - Skeleton Loading + Shimmer

**Video:** media1 (seg 4, implicitamente antes del contenido), media2 (seg 0-1) | **Estado:** YA EXISTE

**Descripcion:**
Mientras carga la pantalla de Cashback, se muestran placeholders grises con un efecto shimmer (brillo que recorre de izquierda a derecha). Se aplica a:
- Las 2 tarjetas de ahorro (savings cards).
- Los chips de filtro (lupa + Marca/Categoria/Ubicacion).
- La seccion "Destacados" completa.
- El grid de marcas inferior.

**Animacion:**
- `ShimmerModifier`: gradiente lineal blanco semitransparente que se desplaza horizontalmente en loop.
- Duracion aprox 1.5s por ciclo, repeticion infinita.
- Al completar la carga (~1.2s), fade out y se revela el contenido real.

**Como se ejecuta en la app:**
Navegar a Cashback desde HomeView. Los skeletons aparecen automaticamente durante 1.2 segundos.

---

### A03 - Staggered Appearance (Fade + Slide Up)

**Video:** media1 (seg 4-5), media2 (seg 1-3) | **Estado:** YA EXISTE

**Descripcion:**
Tras desaparecer los skeletons, cada seccion de la pantalla aparece secuencialmente:
1. Tarjeta "Este mes has ahorrado" (index 0)
2. Tarjeta "Total acumulado" (index 1)
3. Filter chips (index 2)
4. Seccion "Destacados" (index 3)
5. Grid de marcas (index 4)

**Animacion:**
- Cada elemento comienza con `opacity: 0` y `offset(y: 24)`.
- Aparece con spring animation (`response: 0.5, dampingFraction: 0.8`).
- Delay incremental de 0.08s entre cada elemento.

**Media2 vs Media1:**
En media2 (version a mayor resolucion) se ve claramente la secuencia paso a paso: primero aparece la tarjeta izquierda sola, luego la derecha + chips, luego Destacados. La animacion es identica pero se aprecia mas el timing progresivo.

---

### A04 - Animated Counter (Numeros)

**Video:** media1 (seg 4-5), media2 (seg 1-2) | **Estado:** YA EXISTE

**Descripcion:**
Los valores numericos (47,80 EUR y 312,45 EUR) se animan desde 0 hasta su valor final.

**Animacion:**
- Usa `AnimatingNumber` (protocolo `Animatable`).
- Los numeros incrementan rapidamente con `contentTransition(.numericText)`.
- Se sincronizan con el staggered appearance de su contenedor.

**Nota media2:**
En media2 se captura un frame intermedio donde los valores son 47,68/48,63 y 317,91, mostrando la interpolacion en tiempo real. Esto confirma la animacion de conteo.

---

### A05 - Toast Notification (Banner inferior)

**Video:** media1 (seg 5-7) | **Estado:** YA EXISTE

**Descripcion:**
Aprox. 1 segundo despues de que aparece el contenido, aparece un toast en la parte inferior:
- Fondo oscuro redondeado (gris oscuro).
- Icono a la izquierda (globo).
- Texto: "Comparte con tus amigos y gana 50 EUR en cashback".
- Boton "X" para cerrar.

**Animacion:**
- Entra desde abajo con `.move(edge: .bottom).combined(with: .opacity)`.
- Spring animation (`response: 0.3, dampingFraction: 0.8`).
- Auto-dismiss despues de 5 segundos.
- Se puede cerrar manualmente con la X.

---

### A06 - Brand Detail - Hero Parallax

**Video:** media1 (seg 8-25) | **Estado:** YA EXISTE (parcial)

**Descripcion:**
Al navegar al detalle de una marca (Ray-Ban), la parte superior muestra una imagen hero grande que ocupa ~60% de la pantalla. Al hacer scroll:
- La imagen tiene efecto parallax: al hacer scroll hacia arriba, la imagen se comprime pero el logo y texto de la marca se mantienen.
- Al hacer scroll hacia abajo (pull), la imagen se estira (stretch-to-pull).

**En el video vs proyecto actual:**
- **Video:** La imagen hero es una **foto real** de producto (modelo con gafas Ray-Ban). El logo es el logo real de Ray-Ban (circulo rojo con texto script).
- **Proyecto actual:** Usa un gradiente de color como placeholder + circulo con letra "RB". No hay foto real.

**Diferencia clave a implementar:**
Las imagenes de producto reales y los logos reales de las marcas. La mecanica de parallax ya existe en `BrandDetailView` con `GeometryReader`.

---

### A07 - Brand Detail - Scroll Zoom (Imagen)

**Video:** media1 (seg 10-16, 20-25) | **Estado:** NUEVA

**Descripcion:**
En el video se observa que al hacer scroll en la pagina de detalle de Ray-Ban, la imagen hero tiene un efecto de **zoom progresivo**. A medida que el usuario hace scroll hacia arriba:
- La imagen se escala ligeramente (zoom in) mientras se desplaza fuera de la pantalla.
- El contenido de texto se desliza por encima de la imagen con un efecto de overlapping suave.

**Diferencia con el proyecto:**
El proyecto actual solo tiene parallax basico (stretch-to-pull al bajar). No hay efecto de zoom al subir.

---

### A08 - Brand Detail - Staggered Content

**Video:** media1 (seg 16-20) | **Estado:** YA EXISTE

**Descripcion:**
Al cargar el detalle de la marca, el contenido debajo de la imagen aparece progresivamente:
1. Badge "10% cashback" (capsule amarilla)
2. Boton CTA "Visitar web Ray-Ban"
3. "Quedan 3 dias"
4. Descripcion del producto
5. Letra pequena (fine print)
6. Condiciones (reembolso, tiendas, gasto minimo) con iconos
7. Botones de accion (Encuentra la tienda, Ver terminos)
8. CTA repetido al final

Cada elemento aparece con staggered animation identica a A03.

---

### A09 - Brand Search - Sheet + Staggered List

**Video:** media1 (seg 28-31) | **Estado:** YA EXISTE

**Descripcion:**
Al pulsar la lupa en los filter chips, aparece un sheet modal con:
- Campo de busqueda en la parte superior.
- Titulo "Mas buscados".
- Lista de marcas con logo circular + nombre.

**Animacion:**
- Sheet aparece con la transicion nativa de iOS (slide up).
- Las filas de marcas aparecen con staggered animation (fade + slide).
- En el frame 030 de media1 se captura el momento en que las ultimas filas (The North Face, Lego) aun estan en mid-animation (opacidad parcial + blur de movimiento).

---

### A10 - Cards List - Staggered Card Appearance

**Video:** media3 (seg 1-3) | **Estado:** YA EXISTE

**Descripcion:**
Al entrar en "Tus tarjetas":
1. Primero aparece la tarjeta de debito (Aurora gradient) con su info.
2. Luego la tarjeta de credito (multicolor vibrante) con su info.
3. Finalmente el boton "Anade una tarjeta" con borde discontinuo.

**Animacion:**
- Delay de 0.15s entre cada tarjeta (mayor que el cashback).
- Misma mecanica de staggered (fade + slide up + spring).
- Se aprecia en media3 frame_001: la primera tarjeta esta cargando borrosa, frame_002 ya esta nitida.

---

### A11 - Cards List - Toast Promo Banner

**Video:** media3 (seg 3-5) | **Estado:** NUEVA

**Descripcion:**
Poco despues de cargar la lista de tarjetas, aparece un toast/banner en la parte inferior con estilo diferente al toast de Cashback:
- Fondo con gradiente suave rosado/lila.
- Icono circular azul a la izquierda.
- Texto: "Nueva Visa Travel disponible" / "Solicitala ahora y viaja tranquilo".
- Boton "X" para cerrar.

**Diferencia con el proyecto:**
El proyecto actual no tiene toast/banner en `CardsListView`. Solo existe el toast generico de Cashback. Este banner tiene un estilo visual diferente (gradiente claro vs fondo oscuro).

---

### A12 - Card Detail - Navigation Transition

**Video:** media3 (seg 7-10) | **Estado:** YA EXISTE (parcial)

**Descripcion:**
Al pulsar sobre una tarjeta en la lista, se navega al detalle con la transicion nativa de `NavigationStack` (push desde derecha). El detalle muestra:
- Boton "Personalizar" centrado arriba.
- La tarjeta con su gradiente.
- Info: tipo, ultimos 4 digitos, gasto del mes.
- Botones "Bloquear" y "Ver PIN".
- Seccion oscura "Ultimos movimientos" con fondo rounded negro.

---

### A13 - Card Detail - Card Scale on Scroll

**Video:** media3 (seg 15-19) | **Estado:** YA EXISTE

**Descripcion:**
Al hacer scroll hacia arriba en el detalle de la tarjeta:
- La tarjeta se encoge progresivamente (scale down) mientras se desplaza.
- La seccion oscura de "Ultimos movimientos" sube cubriendo el area de la tarjeta.

**Animacion:**
- `cardScale = max(0.7, 1.0 - offset / 600)` via `ScrollOffsetKey`.
- Usa `interactiveSpring` para suavidad.

---

### A14 - Card Detail - Animated Spent Counter

**Video:** media3 (seg 11) | **Estado:** YA EXISTE

**Descripcion:**
El valor "275,73 EUR" (gastado este mes) se anima desde 0 usando `AnimatingNumber`, igual que en Cashback.

---

### A15 - Card Detail - Card Flip 3D (Reverso con datos reales)

**Video:** media3 (seg 12-15) | **Estado:** NUEVA

**Descripcion:**
Al pulsar el boton de refresh/reload (icono circular en la esquina superior derecha de la tarjeta), la tarjeta hace un flip 3D y muestra el **reverso** con datos bancarios reales:
- Numero completo: 4923 2938 2923 3221
- Boton de copiar junto al numero.
- "Valida hasta: 03/2028" con boton copiar.
- "CVV: *** " con boton de ojo para revelar.
- Fondo de la tarjeta cambia a un tono rosado/claro semitransparente.

**Diferencia con el proyecto:**
El proyecto actual tiene `flipCard()` que solo hace una rotacion de 360 grados (giro completo decorativo). **No muestra datos del reverso**. El video muestra un flip real con contenido diferente en cada cara.

**Animacion:**
- Flip 3D en eje Y con `rotation3DEffect`.
- Al llegar a ~90 grados, se intercambia el contenido (front -> back).
- Spring animation con `response: 0.6, dampingFraction: 0.7`.
- Un segundo tap vuelve a girar mostrando el frente.

---

### A16 - Card Detail - Movements Section Reveal

**Video:** media3 (seg 15-18) | **Estado:** YA EXISTE (parcial)

**Descripcion:**
La seccion "Ultimos movimientos" tiene:
- Fondo oscuro redondeado en la parte superior.
- Header con titulo + boton "Filtrar" dropdown.
- Transacciones agrupadas por fecha (Hoy, June 13th, 12th, 11th).
- Cada transaccion con icono circular, titulo, subtitulo y monto colorizado (verde = ingreso, rojo = gasto).
- El staggered appearance se aplica a cada seccion de fecha.

---

### A17 - Card Customize - Full Screen Cover Entry

**Video:** media3 (seg 24-25) | **Estado:** YA EXISTE

**Descripcion:**
Al pulsar "Personalizar", se abre un full screen cover con animacion nativa de iOS (slide up desde abajo). Contiene:
- Header con "X" para cerrar + titulo "Personalizar".
- Titulo grande: "Selecciona tu opcion favorita".
- Preview de la tarjeta con rotacion 3D ligera.
- Tarjeta "peek" detras (siguiente diseño, escala menor, opacidad reducida).
- Fila de thumbnails circulares para seleccionar diseño.
- Boton "Confirmar" oscuro.

---

### A18 - Card Customize - 3D Rotation on Design Switch

**Video:** media3 (seg 25-34) | **Estado:** YA EXISTE (parcial, mejorar)

**Descripcion:**
Al pulsar un thumbnail de diseño diferente:
1. La tarjeta actual rota hacia un lado (45 grados) con desplazamiento lateral.
2. Desaparece brevemente (mid-transition).
3. La nueva tarjeta entra desde el lado opuesto con rotacion y se asienta en posicion central.

**En el video vs proyecto:**
- **Video:** La transicion es mas dramatica. En frame 027 la tarjeta esta practicamente de perfil (edge-on, casi invisible). El cambio de diseño es muy fluido.
- **Proyecto:** La animacion existe pero con rotacion de solo 45 grados y offset de 30px. En el video parece mas agresiva (~90 grados).

**Mejora necesaria:**
Aumentar los angulos de rotacion y el offset para hacer la transicion mas dramatica, como se ve en el video.

---

### A19 - Card Customize - Card Back Preview (Datos reales)

**Video:** media3 (seg 33) | **Estado:** NUEVA

**Descripcion:**
En la pantalla de personalizacion se puede ver brevemente un frame donde la tarjeta muestra el reverso con datos semi-visibles (numero, fecha, CVV) durante la transicion de cambio de diseño. Esto sugiere que el flip de la tarjeta tambien funciona aqui, o que la transicion 3D revela momentaneamente el reverso.

---

### A20 - Brand Grid - Image Cards con fotos reales

**Video:** media1 (seg 1, 5), media2 (seg 5-6) | **Estado:** NUEVA

**Descripcion:**
En la parte inferior de CashbackView, el grid horizontal de marcas muestra **imagenes reales de producto** en lugar de gradientes placeholder:
- **Ray-Ban:** Foto de modelo con gafas de sol (tonos calidos).
- **Lego:** Foto de un castillo Lego (morado/colorido).
- Las imagenes estan en tarjetas con esquinas redondeadas.
- Debajo de cada imagen: nombre de la marca.

**Diferencia con el proyecto:**
El proyecto actual usa `RoundedRectangle` con gradientes del color de la marca como placeholder. No hay fotos reales.

---

## Resumen de estado

### Ya implementadas (funcionan como en el video)
- A02: Skeleton + Shimmer
- A03: Staggered Appearance
- A04: Animated Counter
- A05: Toast Notification
- A08: Brand Detail Staggered Content
- A09: Brand Search Sheet
- A10: Cards List Staggered
- A13: Card Scale on Scroll
- A14: Animated Spent Counter
- A17: Customize Full Screen Cover

### Parcialmente implementadas (necesitan mejoras)
- A06: Hero Parallax (falta foto real, solo tiene gradiente)
- A12: Navigation Transition (basica, funcional)
- A16: Movements Section Reveal (funcional, puede mejorar timing)
- A18: 3D Rotation Design Switch (angulos insuficientes vs video)

### Nuevas (no existen en el proyecto)
- **A01:** Onboarding Bottom Sheet con tarjetas en abanico
- **A07:** Scroll Zoom en imagen hero
- **A11:** Toast promo banner en Cards List
- **A15:** Card Flip 3D con reverso real (datos bancarios)
- **A19:** Card back preview en Customize
- **A20:** Imagenes reales de producto en brand grid y hero

---

## Manual de usuario - Como ejecutar cada animacion

### Requisitos previos
1. Abrir el proyecto `CashbackCardsDemo.xcodeproj` en Xcode 16+.
2. Seleccionar un simulador iOS 17+ (iPhone 15 Pro recomendado).
3. Build & Run (Cmd+R).

---

### HomeView (pantalla inicial)

| Animacion | Como ejecutarla |
|-----------|----------------|
| Staggered cards | Aparece automaticamente al abrir la app. Las 2 tarjetas ("Cashback" y "Tus tarjetas") se animan secuencialmente con fade+slide. |

---

### Flujo Cashback

| Animacion | Como ejecutarla |
|-----------|----------------|
| **A01** Onboarding | **[PENDIENTE]** Se mostraria automaticamente la primera vez que se entra a Cashback. |
| **A02** Skeleton + Shimmer | Pulsar la tarjeta "Cashback" en Home. Los skeletons con shimmer aparecen durante ~1.2 segundos. |
| **A03** Staggered Appearance | Esperar a que terminen los skeletons. Los elementos aparecen uno por uno de arriba a abajo. |
| **A04** Animated Counter | Observar los numeros "47,80 EUR" y "312,45 EUR" en las tarjetas de ahorro; se animan desde 0. |
| **A05** Toast | Esperar ~2.2 segundos (1.2s carga + 1s delay). El banner aparece abajo con "Comparte con tus amigos...". Cerrar con la X o esperar 5 segundos. |
| **A06** Hero Parallax | Pulsar cualquier marca (ej: Ray-Ban en el grid inferior). La imagen hero ocupa la parte superior. Hacer scroll hacia abajo para ver el stretch, y hacia arriba para ver la compresion. |
| **A07** Scroll Zoom | **[PENDIENTE]** En BrandDetailView, al hacer scroll up la imagen haria zoom progresivo. |
| **A08** Staggered Content | En el detalle de marca, observar como cada elemento (badge, boton, texto, condiciones) aparece secuencialmente. |
| **A09** Search Sheet | Desde CashbackView, pulsar el icono de lupa (primer chip). Se abre un sheet modal con barra de busqueda y lista "Mas buscados" con animacion staggered. Escribir para filtrar. Pulsar "Cerrar" para volver. |

---

### Flujo Tarjetas

| Animacion | Como ejecutarla |
|-----------|----------------|
| **A10** Staggered Cards | Desde Home, pulsar "Tus tarjetas". Las tarjetas aparecen secuencialmente con delay de 0.15s. |
| **A11** Toast Promo | **[PENDIENTE]** Un banner tipo "Nueva Visa Travel disponible" apareceria ~2s despues de cargar la lista. |
| **A12** Navigation | Pulsar sobre cualquier tarjeta (debito o credito) para navegar al detalle. |
| **A13** Scale on Scroll | En el detalle de la tarjeta, hacer scroll hacia arriba. La tarjeta se encoge progresivamente (minimo 70% de su tamano). |
| **A14** Animated Spent | Al entrar al detalle, observar "275,73 EUR" (o "1.240,50 EUR" para credito) animarse desde 0. |
| **A15** Card Flip 3D | Pulsar el boton circular con icono de "refresh" (esquina superior derecha de la tarjeta). **Actualmente:** La tarjeta da una vuelta completa decorativa. **[PENDIENTE]:** Deberia mostrar datos del reverso (numero completo, fecha, CVV). |
| **A16** Movements | Hacer scroll en el detalle hasta la seccion oscura "Ultimos movimientos". Los grupos de transacciones aparecen con staggered animation por fecha. |
| **A17** Customize Entry | Pulsar el boton "Personalizar" (chip centrado arriba del detalle). Se abre un full screen cover que sube desde abajo. |
| **A18** 3D Design Switch | En la pantalla de personalizacion, pulsar los thumbnails circulares de colores en la parte inferior. La tarjeta rota en 3D, cambia de diseño y vuelve a su posicion. Probar varios diseños para ver la direccion de rotacion (izquierda/derecha segun la posicion). |
| **A19** Card Back Preview | **[PENDIENTE]** Durante la transicion de diseño, la tarjeta mostraria brevemente su reverso. |

---

### Resumen rapido de navegacion

```
App Launch
  |
  v
HomeView
  |--- tap "Cashback" ---> CashbackView (A01, A02, A03, A04, A05)
  |                           |--- tap lupa ---> BrandSearchView (A09)
  |                           |--- tap marca ---> BrandDetailView (A06, A07, A08)
  |
  |--- tap "Tus tarjetas" --> CardsListView (A10, A11, A20)
                                |--- tap tarjeta ---> CardDetailView (A12, A13, A14, A15, A16)
                                                        |--- tap "Personalizar" ---> CardCustomizeView (A17, A18, A19)
```

---

### Notas adicionales

- Las animaciones marcadas **[PENDIENTE]** son las que se ven en los videos pero aun no estan implementadas en el proyecto.
- La prioridad de implementacion sugerida seria:
  1. **A15** (Card Flip con reverso) - Mayor impacto visual, logica ya parcialmente implementada.
  2. **A01** (Onboarding) - Primera impresion del usuario en el flujo de Cashback.
  3. **A11** (Toast Promo Cards) - Reutiliza la logica de toast existente.
  4. **A07** (Scroll Zoom) - Mejora incremental sobre el parallax existente.
  5. **A18 mejora** (3D Rotation mas dramatica) - Ajuste de parametros.
  6. **A20** (Imagenes reales) - Requiere assets de imagen, no es animacion propiamente.
  7. **A19** (Back preview en Customize) - Depende de A15.
