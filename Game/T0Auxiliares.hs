{- |
Module      : T0Auxiliares
Description : Auxiliares da parte Gráfica
Copyright   : João Carlos Oliveira Vale <a100697@alunos.uminho.pt>; <carlosvalejcov@gmail.com>

Módulo para o uso de auxiliares da parte Gráfica do jogo.
-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

module T0Auxiliares (
      -- * Desenhar Todos
      -- ** Desenhar Menu
    drawMenu, drawMenu2, opcoes,
      -- ** Desenhar Mapa
      -- **** Modo BlockDude
      drawMapaN, drawMapa2N, drawPlayerN, pecasN,
      -- **** Modo DragonBall
      drawMapaDB, drawMapa2DB, drawPlayerDB, pecasDB,
      -- **** Modo AmongUs
    drawMapaA, drawMapa2A, drawPlayerA, pecasA,
      -- ** Desenhar Niveis
    drawNiveis, drawNiveis2, levels,
      -- ** Desenhar Instruções
    drawInstrucoes, instruct,
      -- ** Desenhar Vitória
    drawVitoria, drawVitoria2, victory,
      -- ** Desenhar Background
    backgroundsN, backgroundsDB, backgroundsA,
      -- ** Detetar Porta
    porta, findPorta
    ) where

import T0Dados
import Graphics.Gloss
import Graphics.Gloss.Interface.IO.Game

------------------------------
--- Desenhar Parte do Menu ---
------------------------------

{- | 
Através do 'Translate' e do uso da 'lista' de 'listas', é feito um distanciamento entre as 'Pictures'.
Desta forma, é desenhado primeiro horizontalmente, portanto, começamos por usar o 'Translate' para que, a cada
elemento de uma 'lista' seja feito o distanciamento em __x__. 

 - Os inteiros em 'Translate' variam de acordo com aquilo que for o objetivo de reproduzir na tela.
 - Aplica-se a todos os 'draw'
-}

drawMenu :: ([[Tipos]], [Picture]) -> (Int,Int) -> [Picture]
drawMenu ([], _) _ = []
drawMenu (h:t, menu) (x,y) = Translate (fromIntegral (x*100)) (-55) (Pictures (drawMenu2 (h, menu) y)) : drawMenu (t, menu) (x+1,y)

{- | 
À semelhança da função anterior, aqui também é feito um distanciamento de 'Pictures', mas verticalmente.

Isto é, vai desenhando as colunas (verticalmente), usando também o 'Translate' mas em __y__.

 - Os inteiros em 'Translate' variam de acordo com aquilo que for o objetivo de reproduzir na tela.
 - Aplica-se a todos os 'draw'
-}

drawMenu2 :: ([Tipos], [Picture]) -> Int -> [Picture]
drawMenu2 ([], _) _ = []
drawMenu2 (h:t, menu) y = Translate (-400) (fromIntegral (y*65)) (opcoes (h, menu)) : drawMenu2 (t, menu) (y-1)

{- | 
Esta função utiliza os elementos da 'lista' para atribuir correspondência a cada 'Imagem' desejada!

 - Varia também de acordo com aquilo que cada um pretende reproduzir.
 - Aplica-se a todas as funções deste tipo! 
-}

opcoes :: (Tipos, [Picture]) -> Picture
opcoes (Nada, menu) = Blank
opcoes (Play, menu) = head menu
opcoes (Level, menu) = menu !! 1
opcoes (Tips, menu) = menu !! 2
opcoes (Exit, menu) = menu !! 3
opcoes (Select, menu) = menu !! 4
opcoes (BlockDude, menu) = menu !! 5
opcoes (DragonBall, menu) = menu !! 6
opcoes (AmongUs, menu) = menu !! 7
opcoes (Back, menu) = menu !! 8
opcoes (Theme, menu) = menu !! 9
opcoes (NTheme, menu) = menu !! 10
opcoes (DBTheme, menu) = menu !! 11
opcoes (ATheme, menu) = menu !! 12

------------------------------
--- Desenhar Parte do Mapa ---
------------------------------

drawMapaN :: (Mapa, [Picture]) -> (Int,Int) -> Float -> [Picture]
drawMapaN ([], _) _ _ = []
drawMapaN (h:t, jogo) (x,y) b = Translate (-600) (fromIntegral (y*(-48))) (Pictures (drawMapa2N (h, jogo) x b)) : drawMapaN (t, jogo) (x,y+1) b

drawMapa2N :: ([Peca],[Picture]) -> Int -> Float -> [Picture]
drawMapa2N ([], _) _ _ = []
drawMapa2N (h:t, jogo) x b = Translate (fromIntegral (x*48)) 308 (pecasN (h, jogo) b) : drawMapa2N (t, jogo) (x+1) b

drawPlayerN :: ([Peca], (Int,Int), [Picture]) -> Float -> [Picture]
drawPlayerN ([],(_,_), _) _ = []
drawPlayerN (h:t,(x,y), jogo) b = Translate (fromIntegral (x*48-600)) (fromIntegral (y*(-48))+308) (pecasN (h, jogo) b) : drawPlayerN (t,(x,y+1), jogo) b

drawMapaDB :: (Mapa, [Picture]) -> (Int,Int) -> Float -> [Picture]
drawMapaDB ([], _) _ _ = []
drawMapaDB (h:t, jogo) (x,y) b = Translate (-600) (fromIntegral (y*(-48))) (Pictures (drawMapa2DB (h, jogo) x b)) : drawMapaDB (t, jogo) (x,y+1) b

drawMapa2DB :: ([Peca],[Picture]) -> Int -> Float -> [Picture]
drawMapa2DB ([], _) _ _ = []
drawMapa2DB (h:t, jogo) x b = Translate (fromIntegral (x*48)) 308 (pecasDB (h, jogo) b) : drawMapa2DB (t, jogo) (x+1) b

drawPlayerDB :: ([Peca], (Int,Int), [Picture]) -> Float -> [Picture]
drawPlayerDB ([],(_,_), _) _ = []
drawPlayerDB (h:t,(x,y), jogo) b = Translate (fromIntegral (x*48-600)) (fromIntegral (y*(-48))+308) (pecasDB (h, jogo) b) : drawPlayerDB (t,(x,y+1), jogo) b

drawMapaA :: (Mapa, [Picture]) -> (Int,Int) -> Float -> [Picture]
drawMapaA ([], _) _ _ = []
drawMapaA (h:t, jogo) (x,y) b = Translate (-600) (fromIntegral (y*(-48))) (Pictures (drawMapa2A (h, jogo) x b)) : drawMapaA (t, jogo) (x,y+1) b

drawMapa2A :: ([Peca],[Picture]) -> Int -> Float -> [Picture]
drawMapa2A ([], _) _ _ = []
drawMapa2A (h:t, jogo) x b = Translate (fromIntegral (x*48)) 308 (pecasA (h, jogo) b) : drawMapa2A (t, jogo) (x+1) b

{- | 
Ideologia de todas as outras, no entanto aplica-se ao jogador, simples quanto isto!
-}

drawPlayerA :: ([Peca], (Int,Int), [Picture]) -> Float -> [Picture]
drawPlayerA ([],(_,_), _) _ = []
drawPlayerA (h:t,(x,y), jogo) b = Translate (fromIntegral (x*48-600)) (fromIntegral (y*(-48))+308) (pecasA (h, jogo) b) : drawPlayerA (t,(x,y+1), jogo) b

pecasN :: (Peca, [Picture]) -> Float -> Picture
pecasN (Porta, jogo) b
    | mod (round (b*50)) 200 < 100 = head jogo
    | otherwise = jogo !! 1
pecasN (PersonagemD, jogo) _ = jogo !! 2
pecasN (PersonagemE, jogo) _ = jogo !! 3
pecasN (Bloco, jogo) _ = jogo !! 4
pecasN (Caixa, jogo) _ = jogo !! 5
pecasN (Vazio, jogo) _ = Blank

pecasA :: (Peca, [Picture]) -> Float -> Picture
pecasA (Porta, jogo) _ = jogo !! 6
pecasA (PersonagemD, jogo) _ = jogo !! 7
pecasA (PersonagemE, jogo) _ = jogo !! 8
pecasA (Bloco, jogo) _ = jogo !! 9
pecasA (Caixa, jogo) _ = jogo !! 10
pecasA (Vazio, jogo) _ = Blank

pecasDB :: (Peca, [Picture]) -> Float -> Picture
pecasDB (Porta, jogo) _ = jogo !! 11
pecasDB (PersonagemD, jogo) _ = jogo !! 12
pecasDB (PersonagemE, jogo) _ = jogo !! 13
pecasDB (Bloco, jogo) _ = jogo !! 14
pecasDB (Caixa, jogo) _ = jogo !! 15
pecasDB (Vazio, jogo) _ = Blank

-----------------------
--- Desenhar Niveis ---
----------------------- 

drawNiveis :: ([[Tipos]], [Picture]) -> (Int,Int) -> [Picture]
drawNiveis ([], _) _ = []
drawNiveis (h:t, niveis) (x,y) = Translate (fromIntegral (x*85)) (-70) (Pictures (drawNiveis2 (h, niveis) y)) : drawNiveis (t, niveis) (x+1,y)

drawNiveis2 :: ([Tipos], [Picture]) -> Int -> [Picture]
drawNiveis2 ([], _) _ = []
drawNiveis2 (h:t, niveis) y = Translate (-380) (fromIntegral (y*55)) (levels (h, niveis)) : drawNiveis2 (t, niveis) (y-1)

levels :: (Tipos, [Picture]) -> Picture
levels (Nada, niveis) = Blank
levels (Lvl1, niveis) = head niveis
levels (Lvl2, niveis) = niveis !! 1
levels (Lvl3, niveis) = niveis !! 2
levels (Lvl4, niveis) = niveis !! 3
levels (Lvl5, niveis) = niveis !! 4
levels (Lvl6, niveis) = niveis !! 5
levels (Lvl7, niveis) = niveis !! 6
levels (Lvl8, niveis) = niveis !! 7
levels (Lvl9, niveis) = niveis !! 8
levels (Lvl10, niveis) = niveis !! 9
levels (Back, niveis) = niveis !! 10
levels (Select, niveis) = niveis !! 11
levels (Show1, niveis) = niveis !! 12
levels (Show2, niveis) = niveis !! 13
levels (Show3, niveis) = niveis !! 14
levels (Show4, niveis) = niveis !! 15
levels (Show5, niveis) = niveis !! 16
levels (Show6, niveis) = niveis !! 17
levels (Show7, niveis) = niveis !! 18
levels (Show8, niveis) = niveis !! 19
levels (Show9, niveis) = niveis !! 20
levels (Show10, niveis) = niveis !! 21

--------------------------
--- Desenhar Intrucoes ---
--------------------------

drawInstrucoes :: ([Tipos], [Picture]) -> Int -> [Picture]
drawInstrucoes ([], _) _ = []
drawInstrucoes (h:t, instrucoes) y = Translate 0 (fromIntegral (y*100)) (instruct (h,instrucoes)) : drawInstrucoes (t,instrucoes) (y-1)

instruct :: (Tipos, [Picture]) -> Picture
instruct (Tips, instrucoes) = head instrucoes
instruct (Texto, instrucoes) = instrucoes !! 1
instruct (Back, instrucoes) = instrucoes !! 2
instruct (Select, instrucoes) = instrucoes !! 3

------------------------
--- Desenhar Vitoria ---
------------------------

drawVitoria :: ([[Tipos]], [Picture]) -> (Int,Int) -> [Picture]
drawVitoria ([], _) _ = []
drawVitoria (h:t, vitoria) (x,y) = Translate (fromIntegral (x*90)) (-50) (Pictures (drawVitoria2 (h, vitoria) y)) : drawVitoria (t, vitoria) (x+1,y)

drawVitoria2 :: ([Tipos], [Picture]) -> Int -> [Picture]
drawVitoria2 ([], _) _ = []
drawVitoria2 (h:t, vitoria) y = Translate (-150) (fromIntegral (y*65)) (victory (h, vitoria)) : drawVitoria2 (t, vitoria) (y-1)

victory :: (Tipos, [Picture]) -> Picture
victory (Nada, vitoria) = Blank
victory (WinBaixo, vitoria) = head vitoria
victory (WinCima, vitoria) = vitoria !! 1
victory (Exit, vitoria) = vitoria !! 2
victory (Select, vitoria) = vitoria !! 3
victory (Continue, vitoria) = vitoria !! 4
victory (Level, vitoria) = vitoria !! 5

--- Função para backgrounds ---

{- | 
Estas funções são o que fazem variar o tema também, portanto, criamos uma para cada caso para depois ir alterando
de acordo com cada 'estado'.
-}
{- | 
Esta função utiliza os elementos da 'lista' para atribuir correspondência a cada 'Imagem' desejada!

 - Varia também de acordo com aquilo que cada um pretende reproduzir. 
-}

backgroundsDB :: (Tipos, [Picture]) -> Picture
backgroundsDB (OpcoesGeral, x) = head x
backgroundsDB (NiveisGeral, x) = x !! 1
backgroundsDB (GameGeral, x) = x !! 2

backgroundsN :: (Tipos,[Picture]) -> Picture
backgroundsN (NiveisGeral, x) = x !! 3
backgroundsN (OpcoesGeral, x) = x !! 4
backgroundsN (GameGeral, x) = x !! 5

backgroundsA :: (Tipos,[Picture]) -> Picture
backgroundsA (GameGeral, x) = x !! 6
backgroundsA (NiveisGeral, x) = x !! 7
backgroundsA (OpcoesGeral, x) = x !! 8

--- Função para encontrar a porta! ---

{- | 
Esta é a função que obtém as coordenadas da 'Porta' para poder, durante a 'reageEvento' avaliar se é o __fim__
do nível ou não. Utiliza 'findPorta' como /auxiliar/.
-}

porta :: Jogo -> (Int,Int)
porta (Jogo mapa (Jogador (x1,y1) w bool)) = findPorta mapa 0 0

{- | 
'findPorta' irá ler as 'listas' até encontrar a porta e assim devolver as 'coordenadas' corretas. Isto é,
se a cada elemnto de uma lista não encontrar, irá adicionar __1__ a __x__, se no fim da lista não tiver encontrado e for
para a seguinte, então aumenta __1__ a __y__.
-}

findPorta :: Mapa -> Int -> Int -> (Int,Int)
findPorta [] x y = (0,0)
findPorta ([]:t2) x y = findPorta t2 0 (y+1)
findPorta ((h:t1):t2) x y = if h == Porta then (x,y)
                            else findPorta (t1:t2) (x+1) y