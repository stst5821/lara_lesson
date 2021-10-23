<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Post;

class PostController extends Controller
{
    public function index() {
        $posts = Post::find(1);
        return view('post.index', ['posts' => $posts]);
    }
}
